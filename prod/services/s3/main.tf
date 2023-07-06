resource "aws_s3_bucket" "developer-discovery-images" {
  bucket = "developer-discovery-images"

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}
