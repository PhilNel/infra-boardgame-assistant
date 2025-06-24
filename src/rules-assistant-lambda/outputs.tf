output "function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.rules_assistant.function_name
}

output "function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.rules_assistant.arn
}

output "invoke_arn" {
  description = "ARN to invoke the Lambda function"
  value       = aws_lambda_function.rules_assistant.invoke_arn
}

output "role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_execution.arn
}

output "log_group_name" {
  description = "Name of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.lambda_logs.name
} 