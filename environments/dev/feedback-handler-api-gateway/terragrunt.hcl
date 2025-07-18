include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../src//feedback-handler-api-gateway"
}

locals {
  base = include.root.locals
}

dependency "feedback_handler_lambda" {
  config_path = "../feedback-handler-lambda"
  
  mock_outputs = {
    function_name = "dev-boardgame-assistant-feedback-handler-lambda"
    invoke_arn    = "arn:aws:lambda:eu-west-1:123456789012:function:dev-boardgame-assistant-feedback-handler-lambda"
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
  environment           = local.base.environment
  lambda_function_name  = dependency.feedback_handler_lambda.outputs.function_name
  lambda_invoke_arn     = dependency.feedback_handler_lambda.outputs.invoke_arn
  
  # Custom domain configuration
  custom_domain_name = "feedback.boardgamewarlock.com"
  hosted_zone_id     = dependency.route53.outputs.hosted_zone_id
  certificate_arn    = dependency.api_certificates.outputs.certificate_arns["*.boardgamewarlock.com"]
} 