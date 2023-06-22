# TODO : private subnets 설정
resource "aws_db_subnet_group" "rds_subnet" {
  name       = "database subnet"
  subnet_ids = ["${var.public_subnet}","${var.private_subnet}"]
}


resource "aws_db_instance" "developer_discover_db" {
  identifier = "developer-discover-db"
  allocated_storage    = 10
  db_name              = "developer_discovery"
  engine               = "postgres"
  engine_version       = "15.2"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = var.rds_password
  skip_final_snapshot  = true
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = [var.vpc_security_group_id]
}
