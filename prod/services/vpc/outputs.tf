output "vpc_subnet_first_id" {
  value = aws_subnet.public.id
}

output "ecr_repository_second_id" {
  value = aws_subnet.private.id
}

output "vpc_id" {
  value = aws_vpc.developer_discovery.id
}

output "public_subnet" {
  value = aws_subnet.public.id
}

output "private_subnet" {
  value = aws_subnet.private.id
}

output "vpc_gateway" {
  value = aws_internet_gateway.developer_discovery_gateway
}
