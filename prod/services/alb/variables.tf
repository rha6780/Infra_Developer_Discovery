variable "ec2_id" {
  type = string
}

variable "vpc_security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet" {
  type        = string
}

variable "private_subnet" {
  type        = string
}

variable "vpc_gateway" {
  type        = string
}
