resource "aws_vpc" "developer_discovery" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name  = "developer_discovery-vpc"
    Stage = "prod"
  }
}

resource "aws_subnet" "first_subnet" {
  vpc_id     = aws_vpc.developer_discovery.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name  = "developer_discovery-subnet-1"
    Stage = "prod"
  }
}


resource "aws_subnet" "second_subnet" {
  vpc_id     = aws_vpc.developer_discovery.id
  cidr_block = "10.0.2.0/24"

  availability_zone = "ap-northeast-2b"

  tags = {
    Name  = "developer_discovery-subnet-2"
    Stage = "prod"
  }
}