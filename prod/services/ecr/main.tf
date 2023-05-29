resource "aws_ecr_repository" "developer_discovery" {
  name                 = "developer_discovery"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}