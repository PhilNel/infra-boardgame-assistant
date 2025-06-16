variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "artefact_bucket_name" {
  description = "Name of the S3 bucket containing Lambda deployment packages"
  type        = string
}

variable "timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Lambda function memory allocation in MB"
  type        = number
  default     = 512
}