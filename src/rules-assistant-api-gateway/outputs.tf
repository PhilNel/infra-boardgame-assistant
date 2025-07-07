# =============================================================================
# API Gateway Outputs
# =============================================================================

output "api_gateway_id" {
  description = "ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.main.id
}

output "api_gateway_arn" {
  description = "ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.main.arn
}

output "api_gateway_name" {
  description = "Name of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.main.name
}

output "api_gateway_url" {
  description = "Base URL of the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}"
}

output "api_gateway_stage_name" {
  description = "Name of the API Gateway stage"
  value       = aws_api_gateway_stage.main.stage_name
}

output "api_gateway_execution_arn" {
  description = "Execution ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.main.execution_arn
}

# =============================================================================
# Custom Domain Outputs
# =============================================================================

output "custom_domain_name" {
  description = "Custom domain name for the API"
  value       = var.custom_domain_name != "" ? var.custom_domain_name : null
}

output "custom_domain_regional_domain_name" {
  description = "Regional domain name for the API Gateway custom domain"
  value       = var.custom_domain_name != "" && var.hosted_zone_id != "" ? aws_api_gateway_domain_name.api[0].regional_domain_name : null
}

output "custom_domain_regional_zone_id" {
  description = "Regional zone ID for the API Gateway custom domain"
  value       = var.custom_domain_name != "" && var.hosted_zone_id != "" ? aws_api_gateway_domain_name.api[0].regional_zone_id : null
}

# =============================================================================
# Endpoint URLs
# =============================================================================

output "chat_endpoint_url" {
  description = "Full URL for the chat endpoint"
  value       = var.custom_domain_name != "" && var.hosted_zone_id != "" ? "https://${var.custom_domain_name}/api/v1/chat" : "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/chat"
}

output "games_endpoint_url" {
  description = "Full URL for the games endpoint"
  value       = var.custom_domain_name != "" && var.hosted_zone_id != "" ? "https://${var.custom_domain_name}/api/v1/games" : "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/games"
}

output "health_endpoint_url" {
  description = "Full URL for the health endpoint"
  value       = var.custom_domain_name != "" && var.hosted_zone_id != "" ? "https://${var.custom_domain_name}/api/v1/health" : "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/health"
}

# =============================================================================
# Usage Plans
# =============================================================================

output "free_tier_usage_plan_id" {
  description = "ID of the free tier usage plan"
  value       = aws_api_gateway_usage_plan.free_tier.id
}

output "free_tier_usage_plan_name" {
  description = "Name of the free tier usage plan"
  value       = aws_api_gateway_usage_plan.free_tier.name
}

# =============================================================================
# CloudWatch Resources
# =============================================================================

output "api_gateway_log_group_name" {
  description = "Name of the API Gateway CloudWatch log group"
  value       = aws_cloudwatch_log_group.api_gateway.name
}

output "api_gateway_access_log_group_name" {
  description = "Name of the API Gateway access log group"
  value       = aws_cloudwatch_log_group.api_gateway_access.name
}

# =============================================================================
# Configuration Summary
# =============================================================================

output "api_configuration_summary" {
  description = "Summary of API Gateway configuration"
  value = {
    environment   = var.environment
    custom_domain = var.custom_domain_name != "" ? var.custom_domain_name : null
    endpoints = {
      chat   = var.custom_domain_name != "" && var.hosted_zone_id != "" ? "https://${var.custom_domain_name}/api/v1/chat" : "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/chat"
      games  = var.custom_domain_name != "" && var.hosted_zone_id != "" ? "https://${var.custom_domain_name}/api/v1/games" : "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/games"
      health = var.custom_domain_name != "" && var.hosted_zone_id != "" ? "https://${var.custom_domain_name}/api/v1/health" : "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/health"
    }
    rate_limits = {
      free_tier_daily_quota = var.free_tier_daily_quota
      api_rate_limit        = var.api_throttle_rate_limit
      api_burst_limit       = var.api_throttle_burst_limit
    }
    cors_origins = var.allowed_origins
  }
} 