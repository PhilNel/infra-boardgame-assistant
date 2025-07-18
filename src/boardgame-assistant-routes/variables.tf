variable "hosted_zone_id" {
  description = "Route53 hosted zone ID for boardgamewarlock.com"
  type        = string
}

# Website configuration (chat.boardgamewarlock.com)
variable "website_domain_name" {
  description = "Website domain name"
  type        = string
  default     = "chat.boardgamewarlock.com"
}

variable "website_cloudfront_domain_name" {
  description = "CloudFront domain name for the website"
  type        = string
  default     = ""
}

variable "website_cloudfront_zone_id" {
  description = "CloudFront hosted zone ID for the website"
  type        = string
  default     = ""
}

# API configuration (api.boardgamewarlock.com)
variable "api_domain_name" {
  description = "API Gateway domain name"
  type        = string
  default     = "api.boardgamewarlock.com"
}

variable "api_regional_domain_name" {
  description = "Regional domain name for the API Gateway"
  type        = string
  default     = ""
}

variable "api_regional_zone_id" {
  description = "Regional zone ID for the API Gateway"
  type        = string
  default     = ""
}

# Feedback API configuration (feedback.boardgamewarlock.com)
variable "feedback_api_domain_name" {
  description = "Feedback API Gateway domain name"
  type        = string
  default     = "feedback.boardgamewarlock.com"
}

variable "feedback_api_regional_domain_name" {
  description = "Regional domain name for the Feedback API Gateway"
  type        = string
  default     = ""
}

variable "feedback_api_regional_zone_id" {
  description = "Regional zone ID for the Feedback API Gateway"
  type        = string
  default     = ""
} 