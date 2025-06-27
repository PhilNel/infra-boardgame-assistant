terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  api_name   = "${var.environment}-boardgame-assistant-api"
  stage_name = var.environment

  # Common tags
  tags = {
    Environment = var.environment
    Project     = "boardgame-assistant"
    Component   = "api-gateway"
  }
} 