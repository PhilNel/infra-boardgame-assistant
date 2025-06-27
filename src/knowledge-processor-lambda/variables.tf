variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "artefact_bucket_name" {
  description = "Name of the S3 bucket containing the Lambda deployment package"
  type        = string
}

variable "knowledge_bucket_name" {
  description = "Name of the S3 bucket containing the knowledge base"
  type        = string
}

variable "knowledge_bucket_arn" {
  description = "ARN of the S3 bucket containing the knowledge base"
  type        = string
}

variable "knowledge_table_name" {
  description = "Name of the DynamoDB table for knowledge chunks"
  type        = string
}

variable "knowledge_table_arn" {
  description = "ARN of the DynamoDB table for knowledge chunks"
  type        = string
}

variable "jobs_table_name" {
  description = "Name of the DynamoDB table for processing jobs"
  type        = string
}

variable "jobs_table_arn" {
  description = "ARN of the DynamoDB table for processing jobs"
  type        = string
}

variable "memory_size" {
  description = "Amount of memory in MB for the Lambda function"
  type        = number
  default     = 512
}

variable "timeout" {
  description = "Timeout in seconds for the Lambda function"
  type        = number
  default     = 900 # 15 minutes for processing tasks
}

variable "bedrock_embedding_model_id" {
  description = "Bedrock embedding model ID"
  type        = string
  default     = "amazon.titan-embed-text-v2:0"
}

variable "log_level" {
  description = "Log level (debug, info, warn, error)"
  type        = string
  default     = "info"
}