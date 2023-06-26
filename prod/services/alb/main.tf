resource "aws_alb" "devleoper-discovery-alb" {
  name            = "devleoper-discovery-alb"
  internal        = false
  security_groups = [var.vpc_security_group_id]
  subnets         = [var.public_subnet, var.private_subnet]

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



resource "aws_alb_listener" "http_forward" {
  load_balancer_arn = "${aws_alb.devleoper-discovery-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https_forward" {
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
