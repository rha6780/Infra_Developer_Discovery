#TODO : ec2 리소스 생성 구문 작성 (ami 등)
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
  iam_instance_profile   = var.developer_discover_profile_name

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}
