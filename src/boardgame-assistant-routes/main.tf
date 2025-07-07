terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Route53 record for website (chat.boardgamewarlock.com)
resource "aws_route53_record" "website" {
  count   = var.website_cloudfront_domain_name != "" ? 1 : 0
  zone_id = var.hosted_zone_id
  name    = var.website_domain_name
  type    = "A"

  alias {
    name                   = var.website_cloudfront_domain_name
    zone_id                = var.website_cloudfront_zone_id
    evaluate_target_health = false
  }
}

# Route53 record for API Gateway (api.boardgamewarlock.com)
resource "aws_route53_record" "api" {
  count   = var.api_regional_domain_name != "" ? 1 : 0
  zone_id = var.hosted_zone_id
  name    = var.api_domain_name
  type    = "A"

  alias {
    name                   = var.api_regional_domain_name
    zone_id                = var.api_regional_zone_id
    evaluate_target_health = false
  }
} 