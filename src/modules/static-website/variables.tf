variable "bucket_name" {
  description = "Name of the S3 bucket for static website hosting"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "index_document" {
  description = "Index document for the website"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Error document for the website (important for SPAs)"
  type        = string
  default     = "index.html"
} 