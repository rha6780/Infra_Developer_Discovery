# CodeDeploy iam
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


# EC2 iam
resource "aws_iam_role" "developer_discover_role" {
  name               = "developer_discover_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}

resource "aws_iam_instance_profile" "developer_discover_profile" {
  name = "developer_discover_profile"
  role = aws_iam_role.developer_discover_role.name

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
