variable "s3_domain" {
  type = string
}

variable "s3_id" {
  type = string
}

// alb 쪽에 route53 내용이 있지만, 종료 페이지 용이기 때문에 인프라 변경시 직접 넣도록 함.
// us-east-1 리전의 인증서만 가능
// https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn/issues/55
variable "certificate_arn" {
  type = string
}
