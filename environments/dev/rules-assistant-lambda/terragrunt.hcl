include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  base = include.root.locals
}

terraform {
  source = "../../..//src//rules-assistant-lambda"
}

dependency "knowledge" {
  config_path = "../knowledge"
}

inputs = {
  function_name         = "${local.base.project_name}-rules-assistant-${local.base.environment}"
  timeout               = 30
  memory_size           = 512
  aws_region            = local.base.aws_region
  artefact_bucket_name  = local.base.artefact_bucket_name
  knowledge_bucket_arn  = dependency.knowledge.outputs.bucket_arn
  knowledge_bucket_name = dependency.knowledge.outputs.bucket_name
} 