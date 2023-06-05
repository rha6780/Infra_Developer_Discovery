output "ecr_registry_id" {
  value = aws_ecr_repository.developer_discovery.registry_id
}

output "ecr_repository_url" {
  value = aws_ecr_repository.developer_discovery.repository_url
}
