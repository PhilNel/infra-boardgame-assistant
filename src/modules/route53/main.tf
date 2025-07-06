terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Data source to get existing hosted zone
data "aws_route53_zone" "main" {
  name = var.domain_name
} 