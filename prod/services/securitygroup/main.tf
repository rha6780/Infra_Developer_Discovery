resource "aws_security_group" "developer-discovery-alb-sg" {
  name        = "developer-discovery-alb-sgp"
  description = "Allow 80,443 traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow 8080 from vpc"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow 22 from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow 5432 from vpc"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name  = "developer_discovery-alb-sg"
    Stage = "prod"
  }
}


resource "aws_security_group" "developer-discovery-db-sg" {
  name        = "developer-discovery-db-sgp"
  description = "Allow 5432 traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "allow 5432 from EC2"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.developer-discovery-alb-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name  = "developer_discovery-db-sg"
    Stage = "prod"
  }
}
