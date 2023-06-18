output "developer_discovery_lambda" {
    description = "environment value of lambda function"
    value = aws_lambda_function.developer_discovery
}

output "lambda_invoke_arn" {
    description = "environment value of lambda invoke arn"
    value = aws_lambda_function.developer_discovery.invoke_arn
}

output "lambda_function_name" {
    description = "environment value of lambda name"
    value = aws_lambda_function.developer_discovery.function_name
}