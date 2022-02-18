provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "complete-alb-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "api" {
}

resource "aws_lb_target_group" "ui" {
}

resource "aws_acm_certificate" "this" {}

module "alb" {
  source = "../../"

  project_name = "complete"
  application  = "alb"
  environment  = "dev"

  type            = "application"
  internal        = false
  security_groups = [module.vpc.default_security_group_id]
  subnets         = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  http_listeners = {
    "redirect-to-https" : {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"

      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }

  https_listeners = {
    "forward to ui" : {
      port            = 443
      protocol        = "HTTPS"
      action_type     = "forward"
      ssl_policy      = "ELBSecurityPolicy-2016-08"
      certificate_arn = aws_acm_certificate.this.arn

      forward = {
        target_group_arn = aws_lb_target_group.ui.arn
      }

      rules = {
        "to-api" : {
          action   = "forward"
          priority = 20

          conditions = {
            path_pattern = ["/api*"]
          }

          forward = {
            target_group_arn = aws_lb_target_group.api.arn
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
