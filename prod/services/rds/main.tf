resource "aws_db_instance" "developer_discover_db" {
  identifier = "developer-discover-db"
  allocated_storage    = 10
  db_name              = "developer_discovery"
  engine               = "postgres"
  engine_version       = "15.2"
  instance_class       = "db.t4g.micro"
  username             = "postgres"
  password             = var.rds_password
  skip_final_snapshot  = true
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [var.db_security_group_id]
}
