resource "aws_codedeploy_app" "developer_discovery" {
  compute_platform = "EC2"
  name             = "developer_discovery"

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}
