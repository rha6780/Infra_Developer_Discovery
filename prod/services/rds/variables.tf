variable "rds_password" {
  type        = string
  sensitive   = true
}

variable "db_security_group_id" {
  type        = string
}

variable "db_subnet_group_name" {
  type        = string
}
