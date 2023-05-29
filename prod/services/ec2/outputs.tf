output "ec2_arn" {
    description = "enviroment variable of codedeploy target ec2 arn"
    value = aws_instance.developer_discovery_api.arn
}
