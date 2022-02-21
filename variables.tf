variable "name" {
  type        = string
  description = "AWS Load Balancer name"
}

variable "type" {
  type        = string
  default     = "application"
  description = "AWS load balancer type"
}

variable "internal" {
  type        = bool
  default     = false
  description = "Is AWS Load Balancer internal?"
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

variable "subnet_mapping" {
  type = list(object({
    subnet_id     = string
    allocation_id = string
  }))
  default     = null
  description = "AWS Load Balancer subnet mapping"
}

variable "deletion_protection" {
  type        = string
  default     = false
  description = "AWS LB deletion protection"
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
