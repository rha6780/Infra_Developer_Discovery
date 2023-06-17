output "security_group_id" {
    description = "environment value of security group id"
    value = aws_security_group.developer-discovery-alb-sg.id
}
