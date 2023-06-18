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

# ECR policy
resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr-public-policy"
  description = "A test policy"
  policy      = file("policies/ecr-policy.json")
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  policy_arn = aws_iam_policy.ecr_policy.arn
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

resource "aws_iam_role_policy_attachment" "ecr_to_ec2_policy_attachment" {
  policy_arn = aws_iam_policy.ecr_policy.arn
  role       = aws_iam_role.developer_discover_role.name
}

# Lambda iam
resource "aws_iam_role" "lambda_role" {
  name               = "developer-discovery-lambda-role"
  assume_role_policy = file("policies/lambda-access.json")
}

resource "aws_iam_policy" "lambda_invoke_policy" {
  description = "developer discovery invoke policy"
  name        = "iris-lambda-invoke-policy"
  policy      = file("policies/lambda-invoke.json")
}

resource "aws_iam_role_policy_attachment" "lambda_invoke_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_invoke_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_full_access_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}


