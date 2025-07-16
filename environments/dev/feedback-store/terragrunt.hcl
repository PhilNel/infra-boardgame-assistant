include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  base = include.root.locals
}

terraform {
  source = "../../../src//feedback-store"
}

inputs = {
  environment         = local.base.environment
  feedback_table_name = "${local.base.project_name}-feedback-${local.base.environment}"
} 