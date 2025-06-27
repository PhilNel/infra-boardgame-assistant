output "knowledge_table_name" {
  description = "Name of the knowledge chunks DynamoDB table"
  value       = aws_dynamodb_table.knowledge_chunks.name
}

output "knowledge_table_arn" {
  description = "ARN of the knowledge chunks DynamoDB table"
  value       = aws_dynamodb_table.knowledge_chunks.arn
}

output "jobs_table_name" {
  description = "Name of the processing jobs DynamoDB table"
  value       = aws_dynamodb_table.processing_jobs.name
}

output "jobs_table_arn" {
  description = "ARN of the processing jobs DynamoDB table"
  value       = aws_dynamodb_table.processing_jobs.arn
} 