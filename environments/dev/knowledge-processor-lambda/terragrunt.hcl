include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  base = include.root.locals
}

terraform {
  source = "../../..//src//knowledge-processor-lambda"
}

dependency "knowledge" {
  config_path = "../knowledge"
}

dependency "knowledge_store" {
  config_path = "../knowledge-store"
}

inputs = {
  function_name         = "${local.base.project_name}-knowledge-processor-${local.base.environment}"
  aws_region            = local.base.aws_region
  artefact_bucket_name  = local.base.artefact_bucket_name
  knowledge_bucket_arn  = dependency.knowledge.outputs.bucket_arn
  knowledge_bucket_name = dependency.knowledge.outputs.bucket_name
  
  knowledge_table_name = dependency.knowledge_store.outputs.knowledge_table_name
  knowledge_table_arn  = dependency.knowledge_store.outputs.knowledge_table_arn
  jobs_table_name      = dependency.knowledge_store.outputs.jobs_table_name
  jobs_table_arn       = dependency.knowledge_store.outputs.jobs_table_arn
} 