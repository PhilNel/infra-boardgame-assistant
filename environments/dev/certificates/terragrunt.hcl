include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../src//modules//certificates"
}

locals {
  base = include.root.locals
}

dependency "route53" {
  config_path = "../route53"
  
  mock_outputs = {
    hosted_zone_id = "Z1234567890ABC"
  }
}

# Force certificate creation in us-east-1 for CloudFront compatibility
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}

inputs = {
  environment    = local.base.environment
  hosted_zone_id = dependency.route53.outputs.hosted_zone_id
  
  domains = [
    {
      name                      = "*.boardgamewarlock.com"
      subject_alternative_names = ["boardgamewarlock.com"]
    }
  ]
  
  common_tags = {
    Environment = local.base.environment
    Project     = local.base.project_name
    Component   = "certificates"
  }
} 