include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../src//modules//static-website"
}

locals {
  base = include.root.locals
}

dependency "certificates" {
  config_path = "../certificates"
  
  mock_outputs = {
    certificate_arns = {
      "*.boardgamewarlock.com" = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
    }
  }
}

inputs = {
  environment               = local.base.environment
  bucket_name               = "boardgame-assistant-${local.base.environment}-${local.base.aws_region}"
  domain_name               = "chat.boardgamewarlock.com"
  certificate_arn           = dependency.certificates.outputs.certificate_arns["*.boardgamewarlock.com"]
  enable_cloudfront         = true
  cloudfront_price_class    = "PriceClass_100"
}