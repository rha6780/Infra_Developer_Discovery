output "vpc_subnet_first_id" {
  value = aws_subnet.first_subnet.id
}

output "ecr_repository_second_id" {
  value = aws_subnet.second_subnet.id
}

output "vpc_id" {
  value = aws_vpc.developer_discovery.id
}
