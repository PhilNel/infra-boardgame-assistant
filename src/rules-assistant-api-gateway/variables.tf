# =============================================================================
# Core Configuration
# =============================================================================

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

# =============================================================================
# CORS Configuration
# =============================================================================

variable "allowed_origins" {
  description = "CORS allowed origins"
  type        = list(string)
  default     = ["http://localhost:3000", "http://localhost:5173"]

  validation {
    condition     = length(var.allowed_origins) > 0
    error_message = "At least one allowed origin must be specified."
  }
}

# =============================================================================
# Rate Limiting & Throttling
# =============================================================================

variable "api_throttle_burst_limit" {
  description = "API throttle burst limit (requests per second)"
  type        = number
  default     = 10

  validation {
    condition     = var.api_throttle_burst_limit > 0 && var.api_throttle_burst_limit <= 10000
    error_message = "Burst limit must be between 1 and 10000."
  }
}

variable "api_throttle_rate_limit" {
  description = "API throttle rate limit (requests per second)"
  type        = number
  default     = 5

  validation {
    condition     = var.api_throttle_rate_limit > 0 && var.api_throttle_rate_limit <= 10000
    error_message = "Rate limit must be between 1 and 10000."
  }
}

variable "stage_throttle_rate_limit" {
  description = "Stage-level throttle rate limit (requests per second)"
  type        = number
  default     = 100
}

variable "stage_throttle_burst_limit" {
  description = "Stage-level throttle burst limit (requests per second)"
  type        = number
  default     = 200
}

# =============================================================================
# Usage Plans & Quotas
# =============================================================================

variable "free_tier_daily_quota" {
  description = "Daily request quota for free tier users"
  type        = number
  default     = 50

  validation {
    condition     = var.free_tier_daily_quota > 0
    error_message = "Free tier daily quota must be greater than 0."
  }
}

# =============================================================================
# Logging & Monitoring
# =============================================================================

variable "api_gateway_log_level" {
  description = "API Gateway CloudWatch log level"
  type        = string
  default     = "INFO"

  validation {
    condition     = contains(["OFF", "ERROR", "INFO"], var.api_gateway_log_level)
    error_message = "Log level must be one of: OFF, ERROR, INFO."
  }
}

variable "enable_request_response_logging" {
  description = "Enable request/response data logging (be careful with sensitive data)"
  type        = bool
  default     = false
}