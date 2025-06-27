variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "knowledge_table_name" {
  description = "Name of the DynamoDB table for knowledge chunks"
  type        = string
}

variable "jobs_table_name" {
  description = "Name of the DynamoDB table for processing jobs"
  type        = string
} 