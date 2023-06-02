output "codedeploy_role_arn" {
    description = "enviroment variable of codedeploy iam role arn"
    value = aws_iam_role.codedeploy_role.arn
}

output "developer_discover_profile" {
    description = "enviroment variable of EC2 iam profile"
    value = aws_iam_instance_profile.developer_discover_profile
}
