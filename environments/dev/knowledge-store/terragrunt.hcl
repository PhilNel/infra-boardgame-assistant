include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../..//src//knowledge-store"
}

locals {
  base = include.root.locals
}

inputs = {
  environment           = local.base.environment
  knowledge_table_name  = "${local.base.project_name}-knowledge-chunks-${local.base.environment}"
  jobs_table_name       = "${local.base.project_name}-knowledge-processor-jobs-${local.base.environment}"
} 