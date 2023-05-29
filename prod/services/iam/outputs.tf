output "codedeploy_role_arn" {
    description = "enviroment variable of codedeploy iam role arn"
    value = aws_iam_role.codedeploy_role.arn
}
