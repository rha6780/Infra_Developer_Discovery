resource "aws_cloudfront_origin_access_identity" "developer-discovery-cloudfront-access" {
    comment = "OAI for developer discovery"
}

resource "aws_cloudfront_distribution" "developer-discovery-cloudfront-distribution" {
    enabled = true
    aliases = ["developerdiscovery.com"]
    default_root_object = "/html/developer_discovery.html"
    origin {
        domain_name = var.s3_domain
        origin_id   = var.s3_id
        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.developer-discovery-cloudfront-access.cloudfront_access_identity_path
        }
    }
    default_cache_behavior {
        allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods         = ["GET", "HEAD", "OPTIONS"]
        target_origin_id       = var.s3_id
        viewer_protocol_policy = "redirect-to-https" # other options - https only, http
        forwarded_values {
        headers      = []
        query_string = true
        cookies {
            forward = "all"
        }
        }
    }
    restrictions {
        geo_restriction {
            restriction_type = "whitelist"
            locations        = ["KR"]
        }
    }
    tags = {
        Name  = "developer_discovery"
        Stage = "prod"
    }
    viewer_certificate {
        acm_certificate_arn      = var.certificate_arn
        ssl_support_method       = "sni-only"
        minimum_protocol_version = "TLSv1.2_2018"
    }

}
