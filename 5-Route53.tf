#Create a record in route 53
resource "aws_route53_record" "site-domain" {
  zone_id = data.aws_route53_zone.selected.id
  name = "resumeforhuey.click"
  type = "A"

  alias {
    name   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}