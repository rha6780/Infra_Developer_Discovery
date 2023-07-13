resource "aws_vpc" "developer_discovery" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name  = "developer_discovery-vpc"
    Stage = "prod"
  }
}

# endpoint
# developer-discovery-images s3에 관한 policy 추가 (이름 변경시 주의할 것)
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.developer_discovery.id
  service_name = "com.amazonaws.ap-northeast-2.s3"
  route_table_ids =[aws_route_table.public_route_table.id, aws_route_table.private_route_table.id]
  policy = <<POLICY
  {
	"Version": "2008-10-17",
	"Statement": [
		{
			"Sid": "AccessToS3Bucket",
			"Effect": "Allow",
			"Principal": "*",
			"Action": "s3:*",
			"Resource": [
				"arn:aws:s3:::developer-discovery-images",
				"arn:aws:s3:::developer-discovery-images/*",
        "arn:aws:s3:::prod-ap-northeast-2-starport-layer-bucket/*"
			]
		}
	]
}
POLICY

  tags = {
    Name  = "developer_discovery-vpc"
    Stage = "prod"
  }
}

# subnets
resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.developer_discovery.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name  = "developer_discovery-public-subnet-1"
    Stage = "prod"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.developer_discovery.id
  cidr_block = "10.0.2.0/24"

  availability_zone = "ap-northeast-2b"

  tags = {
    Name  = "developer_discovery-public-subnet-2"
    Stage = "prod"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.developer_discovery.id
  cidr_block = "10.0.102.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name  = "developer_discovery-private-subnet-1"
    Stage = "prod"
  }
}


resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.developer_discovery.id
  cidr_block = "10.0.103.0/24"

  availability_zone = "ap-northeast-2d"

  tags = {
    Name  = "developer_discovery-private-subnet-2"
    Stage = "prod"
  }
}

resource "aws_internet_gateway" "developer_discovery_gateway" {
  vpc_id = aws_vpc.developer_discovery.id

  tags = {
    Name  = "developer_discovery_gateway"
    Stage = "prod"
  }
}

# public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.developer_discovery.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.developer_discovery_gateway.id
  }

  tags = {
    Name  = "developer_discovery_public_route_table"
    Stage = "prod"
  }
}

resource "aws_route_table_association" "public-subnet-1"{
    subnet_id = aws_subnet.public-1.id
    route_table_id = aws_route_table.public_route_table.id
}

# private route
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.developer_discovery.id

  tags = {
    Name  = "developer_discovery_private_route_table"
    Stage = "prod"
  }
}

resource "aws_route_table_association" "private-subnet-1"{
    subnet_id = aws_subnet.private-1.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "developer discovery database subnet group"
  subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id]
}
