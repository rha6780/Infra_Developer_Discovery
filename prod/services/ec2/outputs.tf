output "ec2_arn" {
    description = "enviroment variable of codedeploy target ec2 arn"
    value = aws_instance.developer_discovery_api.arn
}

output "private_key" {
    description = "enviroment variable of ec2 pem key"
    value     = tls_private_key.private_key.private_key_pem
    sensitive = true
}
