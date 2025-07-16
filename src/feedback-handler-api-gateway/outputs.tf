output "api_id" {
  description = "ID of the API Gateway"
  value       = aws_api_gateway_rest_api.main.id
}

output "api_name" {
  description = "Name of the API Gateway"
  value       = aws_api_gateway_rest_api.main.name
}

output "api_execution_arn" {
  description = "Execution ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.main.execution_arn
}

output "stage_name" {
  description = "Name of the API Gateway stage"
  value       = aws_api_gateway_stage.main.stage_name
}

output "stage_arn" {
  description = "ARN of the API Gateway stage"
  value       = aws_api_gateway_stage.main.arn
}

output "invoke_url" {
  description = "URL to invoke the API Gateway"
  value       = aws_api_gateway_stage.main.invoke_url
}

output "feedback_endpoint_url" {
  description = "Full URL for the feedback endpoint"
  value       = var.custom_domain_name != "" ? "https://${var.custom_domain_name}/api/v1/feedback" : "${aws_api_gateway_stage.main.invoke_url}/api/v1/feedback"
}

output "deployment_id" {
  description = "ID of the API Gateway deployment"
  value       = aws_api_gateway_deployment.main.id
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.api_gateway.name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.api_gateway.arn
}

# =============================================================================
# Custom Domain Outputs
# =============================================================================

output "custom_domain_name" {
  description = "Custom domain name for the API"
  value       = var.custom_domain_name != "" ? var.custom_domain_name : null
}

output "regional_domain_name" {
  description = "Regional domain name for the API Gateway"
  value       = length(aws_api_gateway_domain_name.api) > 0 ? aws_api_gateway_domain_name.api[0].regional_domain_name : null
}

output "regional_zone_id" {
  description = "Regional zone ID for the API Gateway"
  value       = length(aws_api_gateway_domain_name.api) > 0 ? aws_api_gateway_domain_name.api[0].regional_zone_id : null
} 