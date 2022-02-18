resource "aws_lb" "this" {
  name = var.name

  internal           = var.internal
  load_balancer_type = var.type
  idle_timeout       = var.idle_timeout

  enable_deletion_protection = var.deletion_protection

  subnets         = var.subnets
  security_groups = var.security_groups

  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_lb_listener" "this" {
  for_each = var.listeners

  port            = lookup(each.value, "port", null)
  protocol        = lookup(each.value, "protocol", null)
  ssl_policy      = lookup(each.value, "ssl_policy", null)
  certificate_arn = lookup(each.value, "certificate_arn", null)

  load_balancer_arn = aws_lb.this.arn

  default_action {
    type = (
      lookup(each.value, "forward", null) != null ? "forward" :
      lookup(each.value, "redirect", null) != null ? "redirect" :
      lookup(each.value, "fixed_response", null) != null ? "fixed-response" :
      null
    )

    target_group_arn = lookup(lookup(each.value, "forward", {}), "target_group_arn", null)

    dynamic "redirect" {
      for_each = (
        lookup(each.value, "redirect", null) != null ?
        [lookup(each.value, "redirect", null)] :
        []
      )

      content {
        port        = lookup(redirect.value, "port", null)
        protocol    = lookup(redirect.value, "protocol", null)
        status_code = lookup(redirect.value, "status_code", null)
      }
    }

    dynamic "fixed_response" {
      for_each = (
        lookup(each.value, "fixed_response", null) != null ?
        [lookup(each.value, "fixed_response", null)] :
        []
      )

      content {
        status_code  = lookup(fixed_response.value, "status_code", null)
        message_body = lookup(fixed_response.value, "message_body", null)
        content_type = lookup(fixed_response.value, "content_type", null)
      }
    }
  }

  tags = merge(var.tags, {
    Name = "${var.name}-${each.key}"
  })
}

resource "aws_lb_listener_rule" "this" {
  for_each = {
    for sub_rule in local.sub_rules :
    "${lookup(sub_rule, "rule_name", null)}/${lookup(sub_rule, "sub_rule_name", null)}" => sub_rule
  }

  priority     = lookup(each.value, "priority", null)
  listener_arn = aws_lb_listener.this[lookup(each.value, "rule_name", null)].arn

  dynamic "action" {
    for_each = (
      lookup(each.value, "authenticate_cognito", null) != null ? [1] :
      lookup(each.value, "authenticate_oidc", null) != null ? [1] :
      []
    )

    content {
      type = (
        lookup(each.value, "authenticate_cognito", null) != null ? "authenticate-cognito" :
        lookup(each.value, "authenticate_oidc", null) != null ? "authenticate-oidc" :
        null
      )

      dynamic "authenticate_cognito" {
        for_each = (
          lookup(each.value, "authenticate_cognito", null) != null ?
          [lookup(each.value, "authenticate_cognito", null)] :
          []
        )

        content {
          user_pool_arn       = lookup(authenticate_cognito.value, "user_pool_arn", null)
          user_pool_client_id = lookup(authenticate_cognito.value, "user_pool_client_id", null)
          user_pool_domain    = lookup(authenticate_cognito.value, "user_pool_domain", null)
        }
      }

      dynamic "authenticate_oidc" {
        for_each = (
          lookup(each.value, "authenticate_oidc", null) != null ?
          [lookup(each.value, "authenticate_oidc", null)] :
          []
        )

        content {
          authorization_endpoint = lookup(authenticate_oidc.value, "authorization_endpoint", null)
          client_id              = lookup(authenticate_oidc.value, "client_id", null)
          client_secret          = lookup(authenticate_oidc.value, "client_secret", null)
          issuer                 = lookup(authenticate_oidc.value, "issuer", null)
          token_endpoint         = lookup(authenticate_oidc.value, "token_endpoint", null)
          user_info_endpoint     = lookup(authenticate_oidc.value, "user_info_endpoint", null)
        }
      }
    }
  }

  action {
    type = (
      lookup(each.value, "forward", null) != null ? "forward" :
      lookup(each.value, "redirect", null) != null ? "redirect" :
      lookup(each.value, "fixed_response", null) != null ? "fixed-response" :
      null
    )

    target_group_arn = lookup(lookup(each.value, "forward", {}), "target_group_arn", null)

    dynamic "redirect" {
      for_each = (
        lookup(each.value, "action", null) == "redirect" ?
        [lookup(each.value, "redirect", null)] :
        []
      )

      content {
        port        = lookup(redirect.value, "port", null)
        protocol    = lookup(redirect.value, "protocol", null)
        status_code = lookup(redirect.value, "status_code", null)
      }
    }

    dynamic "fixed_response" {
      for_each = (
        lookup(each.value, "action", null) == "fixed_response" ?
        [lookup(each.value, "fixed_response", null)] :
        []
      )

      content {
        status_code  = lookup(fixed_response.value, "status_code", null)
        message_body = lookup(fixed_response.value, "message_body", null)
        content_type = lookup(fixed_response.value, "content_type", null)
      }
    }
  }

  dynamic "condition" {
    for_each = lookup(each.value, "conditions", {})

    content {
      dynamic "host_header" {
        for_each = condition.key == "host_header" ? [condition.value] : []

        content {
          values = host_header.value
        }
      }

      dynamic "path_pattern" {
        for_each = condition.key == "path_pattern" ? [condition.value] : []

        content {
          values = path_pattern.value
        }
      }
    }
  }

  tags = merge(var.tags, {
    Name = "${var.name}-${each.key}"
  })
}
