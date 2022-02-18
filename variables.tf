variable "project_name" {
  type        = string
  description = "Project name"
}

variable "application" {
  type        = string
  description = "Current application"
}

variable "environment" {
  type        = string
  description = "Current environment"
}

variable "type" {
  type        = string
  description = "AWS load balancer type"
}

variable "internal" {
  type        = bool
  description = "Is AWS Load Balancer internal?"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC identifier"
}

variable "subnets" {
  type        = list(string)
  description = "AWS LB subnets"
}

variable "security_groups" {
  type        = list(string)
  description = "AWS LB security groups"
}

variable "idle_timeout" {
  type        = number
  default     = 600
  description = "AWS LB idle timeout"
}

variable "deletion_protection" {
  type        = string
  default     = false
  description = "AWS LB deletion protection"
}

variable "acm_certificate" {
  type        = string
  default     = null
  description = "AWS ACM certificate"
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags"
}

variable "listeners" {
  type        = any
  default     = null
  description = "AWS LB listeners"
}
