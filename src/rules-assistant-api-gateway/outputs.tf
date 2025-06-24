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
# Endpoint URLs
# =============================================================================

output "chat_endpoint_url" {
  description = "Full URL for the chat endpoint"
  value       = "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/chat"
}

output "games_endpoint_url" {
  description = "Full URL for the games endpoint"
  value       = "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/games"
}

output "health_endpoint_url" {
  description = "Full URL for the health endpoint"
  value       = "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/health"
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
    environment = var.environment
    endpoints = {
      chat   = "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/chat"
      games  = "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/games"
      health = "https://${aws_api_gateway_rest_api.main.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}/api/v1/health"
    }
    rate_limits = {
      free_tier_daily_quota = var.free_tier_daily_quota
      api_rate_limit        = var.api_throttle_rate_limit
      api_burst_limit       = var.api_throttle_burst_limit
    }
    cors_origins = var.allowed_origins
  }
} 