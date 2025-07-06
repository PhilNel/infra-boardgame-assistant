include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../src//modules//route53"
}

locals {
  base = include.root.locals
}

inputs = {
  environment = local.base.environment
  domain_name = "boardgamewarlock.com"
} 