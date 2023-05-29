resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy_role"
  assume_role_policy = file("policies/codedeploy-assume.json")

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}