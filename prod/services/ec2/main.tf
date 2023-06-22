resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "developer"
  public_key = tls_private_key.private_key.public_key_openssh
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "developer_discovery_api"{
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.generated_key.key_name
  iam_instance_profile   = var.developer_discover_profile_name
  subnet_id = var.public_subnet
  depends_on = [var.vpc_gateway]
  # associate_with_private_ip = "10.0.2.0"
  vpc_security_group_ids = [var.vpc_security_group_id]

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}

resource "aws_eip" "developer_discovery_lb" {
  instance = aws_instance.developer_discovery_api.id
  domain   = "vpc"
  depends_on                = [var.vpc_gateway]

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}
