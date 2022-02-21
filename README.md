# Terraform AWS Application Load Balancer module

Terraform module for AWS provider which creates `aws_lb*` resources

## Usage

### AWS ALB redirect from HTTP to HTTPS

```terraform
module "alb" {
  source  = "edelwud/alb/aws"
  version = "x.x.x"

  name = "redirect-http-https"

  type     = "application"
  internal = false
  subnets  = module.vpc.public_subnets

  security_groups = [
    module.vpc.default_security_group_id,
    module.lb_sg.security_group_id
  ]

  listeners = {
    "http-to-https" = {
      port     = 80
      protocol = "HTTP"

      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    "https" = {
      port            = 433
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-2016-08"
      certificate_arn = aws_acm_certificate.example.arn

      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed response content"
        status_code  = "200"
      }
    }
  }
}
```

### AWS ALB listener rules

```terraform
module "alb" {
  source  = "edelwud/alb/aws"
  version = "x.x.x"

  name = "listener-rules"

  type     = "application"
  internal = false
  subnets  = module.vpc.public_subnets

  security_groups = [
    module.vpc.default_security_group_id,
    module.lb_sg.security_group_id
  ]

  listeners = {
    "http-to-https" = {
      port     = 80
      protocol = "HTTP"

      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }

      rules = {
        "if-path-pattern-is-api" = {
          priority = 20

          condition = {
            path_pattern = ["/api*"]
          }

          forward = {
            target_group_arn = aws_lb_target_group.api.arn
          }
        }
      }
    }

    "https" = {
      port            = 433
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-2016-08"
      certificate_arn = aws_acm_certificate.example.arn

      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed response content"
        status_code  = "200"
      }

      rules = {
        "if-path-pattern-is-api" = {
          priority = 20

          condition = {
            path_pattern = ["/api*"]
          }

          forward = {
            target_group_arn = aws_lb_target_group.api.arn
          }
        }

        "if-host-header-is-example-and-method-is-get" = {
          priority = 20

          condition = {
            host_header         = ["example.com"]
            http_request_method = ["GET"]
          }

          forward = {
            target_group_arn = aws_lb_target_group.ui.arn
          }
        }
      }
    }
  }
}
```

### AWS ALB Cognito & OIDC

```terraform
module "alb" {
  source  = "edelwud/alb/aws"
  version = "x.x.x"

  name = "cognito-oidc"

  type     = "application"
  internal = false
  subnets  = module.vpc.public_subnets

  security_groups = [
    module.vpc.default_security_group_id,
    module.lb_sg.security_group_id
  ]

  listeners = {
    "access-to-fixed-response-after-oidc" = {
      port            = 433
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-2016-08"
      certificate_arn = aws_acm_certificate.example.arn

      authenticate_oidc = {
        authorization_endpoint = "https://example.com/authorization_endpoint"
        client_id              = "client_id"
        client_secret          = "client_secret"
        issuer                 = "https://example.com"
        token_endpoint         = "https://example.com/token_endpoint"
        user_info_endpoint     = "https://example.com/user_info_endpoint"
      }

      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed response content"
        status_code  = "200"
      }

      rules = {
        "cognito-before-api" = {
          priority = 20

          conditions = {
            path_pattern = ["/api*"]
          }

          authenticate_cognito = {
            user_pool_arn       = aws_cognito_user_pool.pool.arn
            user_pool_client_id = aws_cognito_user_pool_client.client.id
            user_pool_domain    = aws_cognito_user_pool_domain.domain.domain
          }

          forward = {
            target_group_arn = aws_lb_target_group.api.arn
          }
        }
      }
    }
  }
}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.67 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.67 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | AWS ALB access logs | <pre>object({<br>    bucket  = string<br>    prefix  = string<br>    enabled = bool<br>  })</pre> | `null` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | AWS LB deletion protection | `string` | `false` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | AWS LB idle timeout | `number` | `600` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Is AWS Load Balancer internal? | `bool` | `false` | no |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | AWS LB listeners | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | AWS Load Balancer name | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | AWS LB security groups | `list(string)` | n/a | yes |
| <a name="input_subnet_mapping"></a> [subnet\_mapping](#input\_subnet\_mapping) | AWS Load Balancer subnet mapping | <pre>list(object({<br>    subnet_id     = string<br>    allocation_id = string<br>  }))</pre> | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | AWS LB subnets | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | AWS load balancer type | `string` | `"application"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | AWS Load Balancer ARN |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | AWS Load Balancer DNS name |
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | AWS Load Balancer identifiers |
| <a name="output_lb_listener_rules"></a> [lb\_listener\_rules](#output\_lb\_listener\_rules) | AWS Load Balancer listener rules ARN |
| <a name="output_lb_listeners"></a> [lb\_listeners](#output\_lb\_listeners) | AWS Load Balancer listeners ARN |
| <a name="output_lb_zone_id"></a> [lb\_zone\_id](#output\_lb\_zone\_id) | AWS Load Balancer Hosted Zone identifier |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
