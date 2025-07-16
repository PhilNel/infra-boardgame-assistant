variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to integrate with API Gateway"
  type        = string

  validation {
    condition     = length(var.lambda_function_name) > 0
    error_message = "Lambda function name cannot be empty."
  }
}

variable "lambda_invoke_arn" {
  description = "ARN to invoke the Lambda function"
  type        = string

  validation {
    condition     = length(var.lambda_invoke_arn) > 0
    error_message = "Lambda invoke ARN cannot be empty."
  }
}

# =============================================================================
# Custom Domain Configuration
# =============================================================================

variable "custom_domain_name" {
  description = "Custom domain name for the API (e.g., feedback.boardgamewarlock.com)"
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID for the custom domain"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ACM certificate ARN for the custom domain (required when using custom domain)"
  type        = string
  default     = ""
}