
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

resource "aws_route53_record" "product_dns" {
  zone_id        = aws_route53_zone.devleoper_discovery_zone.id
  name           = ""
  type           = "A"
  set_identifier = "developer_discovery"

  latency_routing_policy {
    region = "ap-northeast-2"
  }

  alias {
    name                   = "${aws_alb.devleoper-discovery-alb.dns_name}"
    zone_id                = "${aws_alb.devleoper-discovery-alb.zone_id}"
    evaluate_target_health = true
  }
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

# host zone 부터
data "aws_acm_certificate" "developer_discovery_domain_certi"   { 
  domain   = "developerdiscovery.com"
  statuses = ["ISSUED"]
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = "${aws_alb.devleoper-discovery-alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${data.aws_acm_certificate.developer_discovery_domain_certi.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.developer-discovery-api.arn}"
    type             = "forward"
  }
}
