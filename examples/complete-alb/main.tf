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
  security_groups = [module.vpc.default_security_group_id]
  subnets         = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  listeners = {
    "redirect-to-https" = {
      port     = 80
      protocol = "HTTP"

      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }

      rules = {
        "to-api" = {
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
