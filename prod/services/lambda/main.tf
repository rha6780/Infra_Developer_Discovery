resource "aws_lambda_function" "developer_discovery" {
  function_name = "developer_discovery"
  description   = "developer_discovery - https://github.com/rha6780/Infra_Developer_Discovery"
  role          = var.lambda_role_arn
  image_uri     = "${var.ecr_repository_url}:latest"
  package_type  = "Image"

  vpc_config {
    subnet_ids         = [var.vpc_subnet_id]
    security_group_ids = [var.security_group_id]
  }

  # TODO: 수동 설정
  environment {
    variables = {
      ENV                = "prod"
    }
  }

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}
