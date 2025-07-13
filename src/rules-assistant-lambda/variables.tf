variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "artefact_bucket_name" {
  description = "Name of the S3 bucket containing the Lambda deployment package"
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

variable "bedrock_embedding_model_id" {
  description = "Bedrock embedding model ID for vector search"
  type        = string
  default     = "amazon.titan-embed-text-v2:0"
}

variable "log_level" {
  description = "Log level for the Lambda function"
  type        = string
  default     = "INFO"
}

variable "rag_min_similarity" {
  description = "Minimum similarity threshold for vector search"
  type        = number
  default     = 0.40
}

variable "bedrock_model_id" {
  description = "Bedrock model ID for the Lambda function"
  type        = string
  default     = "anthropic.claude-3-haiku-20240307-v1:0"
}

variable "bedrock_max_tokens" {
  description = "Maximum tokens for the Bedrock model"
  type        = number
  default     = 1500
}

variable "bedrock_top_p" {
  description = "TopP for the Bedrock model"
  type        = number
  default     = 0.9
}

variable "rag_max_tokens" {
  description = "Maximum tokens for the RAG"
  type        = number
  default     = 2000
}

variable "rag_vector_weight" {
  description = "Weight for vector search in hybrid mode"
  type        = number
  default     = 0.7
}

variable "rag_keyword_weight" {
  description = "Weight for keyword search in hybrid mode"
  type        = number
  default     = 0.3
}