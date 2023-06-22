variable "rds_password" {
  type        = string
  sensitive   = true
}

variable "vpc_security_group_id" {
  type        = string
}

variable "public_subnet" {
  type        = string
}

variable "private_subnet" {
  type        = string
}

