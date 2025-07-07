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

dependency "knowledge_store" {
  config_path = "../knowledge-store"
}

inputs = {
  function_name         = "${local.base.project_name}-rules-assistant-${local.base.environment}"
  timeout               = 30
  memory_size           = 512
  aws_region            = local.base.aws_region
  artefact_bucket_name  = local.base.artefact_bucket_name
  knowledge_table_name  = dependency.knowledge_store.outputs.knowledge_table_name
  knowledge_table_arn   = dependency.knowledge_store.outputs.knowledge_table_arn
  bedrock_model_id      = "anthropic.claude-3-haiku-20240307-v1:0"
  bedrock_top_p         = 0.9
  rag_min_similarity    = 0.25
  rag_max_tokens        = 2500
} 