output "feedback_table_name" {
  description = "Name of the DynamoDB table for feedback submissions"
  value       = aws_dynamodb_table.feedback_submissions.name
}

output "feedback_table_arn" {
  description = "ARN of the DynamoDB table for feedback submissions"
  value       = aws_dynamodb_table.feedback_submissions.arn
}
