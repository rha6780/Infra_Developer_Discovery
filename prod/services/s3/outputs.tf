output "bucket_domain_name" {
    description = "images and html s3 domain name"
    value = aws_s3_bucket.developer-discovery-images.bucket_regional_domain_name
}

output "bucket_id" {
    description = "images and html s3 arn id"
    value = aws_s3_bucket.developer-discovery-images.id
}
