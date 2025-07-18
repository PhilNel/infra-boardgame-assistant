variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "feedback_table_name" {
  description = "Name of the DynamoDB table for feedback submissions"
  type        = string
}
