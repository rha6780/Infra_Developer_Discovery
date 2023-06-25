
# resource "aws_s3_bucket_lifecycle_configuration" "alb-access" {
#   bucket = "developer-discovery-alb-log"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::164899418867:root"
#       },
#       "Action": "s3:PutObject",
#       "Resource": "arn:aws:s3:::alb-log-example.com/*"
#     }
#   ]
# }
#   EOF

#   lifecycle_rule {
#     id      = "log_lifecycle"
#     prefix  = ""
#     enabled = true

#     transition {
#       days          = 30
#       storage_class = "GLACIER"
#     }

#     expiration {
#       days = 90
#     }
#   }

#   lifecycle {
#     prevent_destroy = true
#   }
# }

resource "aws_alb" "devleoper-discovery-alb" {
  name            = "devleoper-discovery-alb"
  internal        = false
  security_groups = [var.vpc_security_group_id]
  subnets         = [var.public_subnet, var.private_subnet]

#   access_logs {
#     bucket  = "${aws_s3_bucket_lifecycle_configuration.alb-access.id}"
#     prefix  = "developer-discovery-alb"
#     enabled = true
#   }

  tags = {
    Name  = "developer_discovery"
    Stage = "prod"
  }


  lifecycle { 
    create_before_destroy = true
  }
}


resource "aws_alb_target_group" "developer-discovery-api" {
  name     = "api-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/ping"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  lifecycle { 
    create_before_destroy = true
    ignore_changes = [port]
  }

  tags = { 
    Name  = "developer_discovery"
    Stage = "prod"
  }
}

resource "aws_alb_target_group_attachment" "developer-discovery-api" {
  target_group_arn = "${aws_alb_target_group.developer-discovery-api.arn}"
  target_id        = var.ec2_id
  port             = 80
}


# route 53
# hosted zone 이 먼저 적용되고, 이후 다른 것들이 적용 가능 그런게 아니라면
# no ACM Certificate matching domain 에러가 나옴
resource "aws_route53_zone" "devleoper_discovery_zone" {
  name = "developerdiscovery.com."
}

# host zone 부터
resource "aws_acm_certificate" "developer_discovery_com"   { 
  domain_name   = "developerdiscovery.com"
  validation_method = "DNS"
  
  lifecycle {
    create_before_destroy = true
  }

  tags = { 
    Name  = "developer_discovery"
    Stage = "prod"
  }
}

resource "aws_route53_record" "developer_discovery_record" {
  for_each = {
    for dvo in aws_acm_certificate.developer_discovery_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.devleoper_discovery_zone.id
}

# certification 연결을 위해 validation 사용
resource "aws_acm_certificate_validation" "developer_discovery_certi_validation" {
  certificate_arn         = aws_acm_certificate.developer_discovery_com.arn
  validation_record_fqdns = [for record in aws_route53_record.developer_discovery_record : record.fqdn]
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.devleoper-discovery-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.developer-discovery-api.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = "${aws_alb.devleoper-discovery-alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${aws_acm_certificate_validation.developer_discovery_certi_validation.certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.developer-discovery-api.arn}"
    type             = "forward"
  }
}
