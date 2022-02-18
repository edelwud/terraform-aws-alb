locals {
  sub_rules = flatten([
    for rule_name, rule_payload in var.listeners : [
      for sub_rule_name, sub_rule_payload in lookup(rule_payload, "rules", {}) : {
        rule_name     = rule_name
        sub_rule_name = sub_rule_name

        action   = lookup(sub_rule_payload, "action", null)
        priority = lookup(sub_rule_payload, "priority", null)

        conditions = lookup(sub_rule_payload, "conditions", null)

        authenticate_cognito = lookup(sub_rule_payload, "authenticate_cognito", null)
        authenticate_oidc    = lookup(sub_rule_payload, "authenticate_oidc", null)

        redirect       = lookup(sub_rule_payload, "redirect", null)
        forward        = lookup(sub_rule_payload, "forward", null)
        fixed_response = lookup(sub_rule_payload, "fixed_response", null)
      }
    ]
  ])
}
