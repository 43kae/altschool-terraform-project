resource "aws_route53_zone" "demo_route" {
  name = "43kae.me."
}

resource "aws_route53_record" "demo_A_record" {
  zone_id = aws_route53_zone.demo_route.zone_id
  name    = "terraform-test.43kae.me"
  type    = "A"

  alias {
    name                   = aws_alb.demo_alb.dns_name
    zone_id               = aws_alb.demo_alb.zone_id
    evaluate_target_health = true
  }
}