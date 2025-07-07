include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../src//rules-assistant-api-gateway"
}

locals {
  base = include.root.locals
}

dependency "rules_assistant_lambda" {
  config_path = "../rules-assistant-lambda"
  
  mock_outputs = {
    function_name = "dev-boardgame-assistant-rules-assistant-lambda"
  }
}

dependency "route53" {
  config_path = "../route53"
  
  mock_outputs = {
    hosted_zone_id = "Z1234567890ABC"
  }
}

dependency "api_certificates" {
  config_path = "../api-certificates"
  
  mock_outputs = {
    certificate_arns = {
      "*.boardgamewarlock.com" = "arn:aws:acm:eu-west-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
    }
  }
}

inputs = {
  environment = local.base.environment
  lambda_function_name = dependency.rules_assistant_lambda.outputs.function_name
  
  # Custom domain configuration
  custom_domain_name = "api.boardgamewarlock.com"
  hosted_zone_id     = dependency.route53.outputs.hosted_zone_id
  certificate_arn    = dependency.api_certificates.outputs.certificate_arns["*.boardgamewarlock.com"]
  
  allowed_origins = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
    "https://chat.boardgamewarlock.com",
  ]
  
  enable_request_response_logging = true
} 