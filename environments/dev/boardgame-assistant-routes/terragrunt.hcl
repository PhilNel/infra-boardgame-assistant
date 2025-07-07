include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../src//boardgame-assistant-routes"
}

locals {
  base = include.root.locals
}

dependency "route53" {
  config_path = "../route53"
  
  mock_outputs = {
    hosted_zone_id = "Z1234567890ABC"
  }
}

dependency "website" {
  config_path = "../boardgame-assistant-website"
  
  mock_outputs = {
    cloudfront_domain_name    = "d123456789.cloudfront.net"
    cloudfront_hosted_zone_id = "Z2FDTNDATAQYW2"
  }
}

dependency "api_gateway" {
  config_path = "../rules-assistant-api-gateway"
  
  mock_outputs = {
    custom_domain_regional_domain_name = "api123456789.execute-api.us-east-1.amazonaws.com"
    custom_domain_regional_zone_id     = "Z1UJRXOUMOOFQ8"
  }
}

inputs = {
  environment    = local.base.environment
  hosted_zone_id = dependency.route53.outputs.hosted_zone_id
  
  # Website DNS configuration
  website_cloudfront_domain_name = dependency.website.outputs.cloudfront_domain_name
  website_cloudfront_zone_id     = dependency.website.outputs.cloudfront_hosted_zone_id
  
  # API Gateway DNS configuration
  api_regional_domain_name = dependency.api_gateway.outputs.custom_domain_regional_domain_name
  api_regional_zone_id     = dependency.api_gateway.outputs.custom_domain_regional_zone_id
} 