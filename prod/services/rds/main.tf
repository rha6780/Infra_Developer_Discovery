variable "rds_password" {
  type = string
}

# TODO : private subnets 설정
resource "aws_db_instance" "developer_discover_db" {
  allocated_storage    = 10
  db_name              = "developer_discovery"
  engine               = "postgres"
  engine_version       = "15.1"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = var.rds_password
  skip_final_snapshot  = true
}
