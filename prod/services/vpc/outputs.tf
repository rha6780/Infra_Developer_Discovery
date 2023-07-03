output "vpc_subnet_first_id" {
  value = aws_subnet.public-1.id
}

output "ecr_repository_second_id" {
  value = aws_subnet.private-1.id
}

output "vpc_id" {
  value = aws_vpc.developer_discovery.id
}

output "public_subnet-1" {
  value = aws_subnet.public-1.id
}

output "public_subnet-2" {
  value = aws_subnet.public-2.id
}

output "private_subnet-1" {
  value = aws_subnet.private-1.id
}

output "private_subnet-2" {
  value = aws_subnet.private-2.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.name
}

output "vpc_gateway" {
  value = aws_internet_gateway.developer_discovery_gateway
}
