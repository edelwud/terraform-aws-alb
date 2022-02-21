output "lb_id" {
  value       = aws_lb.this.id
  description = "AWS Load Balancer identifiers"
}

output "lb_arn" {
  value       = aws_lb.this.arn
  description = "AWS Load Balancer ARN"
}

output "lb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "AWS Load Balancer DNS name"
}

output "lb_zone_id" {
  value       = aws_lb.this.zone_id
  description = "AWS Load Balancer Hosted Zone identifier"
}

output "lb_listeners" {
  value       = aws_lb_listener.this
  description = "AWS Load Balancer listeners ARN"
}

output "lb_listener_rules" {
  value       = aws_lb_listener_rule.this
  description = "AWS Load Balancer listener rules ARN"
}
