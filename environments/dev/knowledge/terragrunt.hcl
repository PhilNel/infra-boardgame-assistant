include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../src//modules//artefacts"
}

locals {
  base = include.root.locals
}

inputs = {
  environment = local.base.environment
  aws_region  = local.base.aws_region
  bucket_name = "boardgame-assistant-knowledge-${local.base.environment}-${local.base.aws_region}"
} 