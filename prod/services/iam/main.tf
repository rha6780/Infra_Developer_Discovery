resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy_role"
  assume_role_policy = file("policies/codedeploy-assume.json")

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy_role.name
}

resource "aws_iam_role_policy_attachment" "codedeploy_full_access_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
  role       = aws_iam_role.codedeploy_role.name
}
