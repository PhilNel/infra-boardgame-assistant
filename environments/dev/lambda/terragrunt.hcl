include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  base = include.root.locals
}

terraform {
  source = "../../..//src//lambda"
}

inputs = {
  function_name        = "${local.base.project_name}-rules-assistant-${local.base.environment}"
  timeout              = 30
  memory_size          = 512
  aws_region           = local.base.aws_region
  artefact_bucket_name = local.base.artefact_bucket_name
} 