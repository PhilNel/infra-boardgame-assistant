include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../src//modules//static-website"
}

locals {
  base = include.root.locals
}

inputs = {
  environment = local.base.environment
  bucket_name = "boardgame-assistant-${local.base.environment}-${local.base.aws_region}"
}