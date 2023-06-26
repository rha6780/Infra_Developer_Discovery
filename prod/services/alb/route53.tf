# route 53
# hosted zone 이 먼저 적용되고, 이후 다른 것들이 적용 가능 그런게 아니라면
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

# certification 연결을 위해 validation 사용
resource "aws_acm_certificate_validation" "developer_discovery_certi_validation" {
  certificate_arn         = aws_acm_certificate.developer_discovery_com.arn
  validation_record_fqdns = [for record in aws_route53_record.developer_discovery_record : record.fqdn]
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

resource "aws_route53_record" "developer_discovery" {
  zone_id = aws_route53_zone.devleoper_discovery_zone.zone_id
  name    = "developerdiscovery.com"
  type    = "A"

   alias {
    name                   = aws_alb.devleoper-discovery-alb.dns_name
    zone_id                = aws_alb.devleoper-discovery-alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "developer_discovery_www" {
  zone_id = aws_route53_zone.devleoper_discovery_zone.zone_id
  name    = "www.developerdiscovery.com"
  type    = "A"

   alias {
    name                   = aws_alb.devleoper-discovery-alb.dns_name
    zone_id                = aws_alb.devleoper-discovery-alb.zone_id
    evaluate_target_health = true
  }
}
