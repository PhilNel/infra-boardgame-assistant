variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "artefact_bucket_name" {
  description = "Name of the S3 bucket containing the Lambda deployment package"
  type        = string
}

variable "feedback_table_name" {
  description = "Name of the DynamoDB table for feedback submissions"
  type        = string
}

variable "feedback_table_arn" {
  description = "ARN of the DynamoDB table for feedback submissions"
  type        = string
}

variable "memory_size" {
  description = "Amount of memory in MB for the Lambda function"
  type        = number
  default     = 256
}

variable "timeout" {
  description = "Timeout in seconds for the Lambda function"
  type        = number
  default     = 30
}

variable "log_level" {
  description = "Log level for the Lambda function"
  type        = string
  default     = "INFO"
} 