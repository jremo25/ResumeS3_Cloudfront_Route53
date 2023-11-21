#Get the acm certificate issued to our domain name
data "aws_acm_certificate" "issued" {
  domain = "resumeforhuey.click"
  statuses = ["ISSUED"]
  most_recent = true
}

#Get the route53 id 
data "aws_route53_zone" "selected" {
  name         = "resumeforhuey.click"
}
#Get the s3 origin id
locals {
  s3_origin_id = "myS3Origin"
}