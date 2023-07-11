resource "aws_s3_bucket" "developer-discovery-images" {
  bucket = "developer-discovery-images"

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }
}

# 특정 VPC 내부에서만 접근 가능
resource "aws_s3_bucket_policy" "developer_discovery_vpc_only_policy" {
  bucket = aws_s3_bucket.developer-discovery-images.id
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Id": "Policy1415115909152",
    "Statement": [
      {
        "Sid": "Access-to-specific-VPCE-only",
        "Principal": "*",
        "Action": "s3:*",
        "Effect": "Allow",
        "Resource": ["arn:aws:s3:::developer-discovery-images/*"],
        "Condition": {
          "StringEquals": {
            "aws:SourceVpc": "${var.vpc_id}",
            "aws:SourceVpce": "${var.s3_vpce_id}"
          }
        }
      }
    ]
  }
  POLICY
}
