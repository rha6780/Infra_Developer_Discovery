resource "aws_vpc" "developer_discovery" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name  = "developer_discovery-vpc"
    Stage = "prod"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.developer_discovery.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name  = "developer_discovery-subnet-1"
    Stage = "prod"
  }
}


resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.developer_discovery.id
  cidr_block = "10.0.2.0/24"

  availability_zone = "ap-northeast-2b"

  tags = {
    Name  = "developer_discovery-subnet-2"
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
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public_route_table.id
}

# private route
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.developer_discovery.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.developer_discovery_gateway.id
  }

  tags = {
    Name  = "developer_discovery_private_route_table"
    Stage = "prod"
  }
}

resource "aws_route_table_association" "private-subnet-1"{
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private_route_table.id
}
