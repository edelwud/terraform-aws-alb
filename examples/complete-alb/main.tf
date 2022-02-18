provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "complete-alb-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "lb_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "complete-alb-dev"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["https-443-tcp", "http-80-tcp"]
}

resource "aws_lb_target_group" "api" {
  name     = "complete-alb-dev-1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_target_group" "ui" {
  name     = "complete-alb-dev-2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

module "alb" {
  source = "../../"

  name = "complete-alb-dev"

  type            = "application"
  internal        = false
  security_groups = [module.vpc.default_security_group_id, module.lb_sg.security_group_id]
  subnets         = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  listeners = {
    "for-example-1" = {
      port     = 80
      protocol = "HTTP"

      authenticate_cognito = {
        user_pool_arn       = "aws_cognito_user_pool.pool.arn"
        user_pool_client_id = "aws_cognito_user_pool_client.client.id"
        user_pool_domain    = "aws_cognito_user_pool_domain.domain.domain"
      }

      fixed_response = {
        content_type = "text/plain"
        message_body = "HEALTHY"
        status_code  = "200"
      }

      rules = {
        "to-api" = {
          priority = 20

          conditions = {
            host_header  = ["example.com"]
            path_pattern = ["/api*"]
            query_string = [
              {
                key   = "health"
                value = "check"
              },
              {
                key   = "something"
                value = "else"
              },
            ]
          }

          forward = {
            target_group_arn = aws_lb_target_group.api.arn
          }
        }
        "to-ui" = {
          priority = 40

          authenticate_oidc = {
            authorization_endpoint = "https://example.com/authorization_endpoint"
            client_id              = "client_id"
            client_secret          = "client_secret"
            issuer                 = "https://example.com"
            token_endpoint         = "https://example.com/token_endpoint"
            user_info_endpoint     = "https://example.com/user_info_endpoint"
          }

          conditions = {
            http_header = [
              {
                http_header_name = "X-Ops"
                values           = ["for", "example"]
              }
            ]
            http_request_method = ["GET", "POST"]
            source_ip           = ["127.0.0.1/32"]
          }

          forward = {
            target_group_arn = aws_lb_target_group.ui.arn
          }
        }
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
