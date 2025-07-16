include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  base = include.root.locals
}

terraform {
  source = "../../../src//feedback-handler-lambda"
}

dependency "feedback_store" {
  config_path = "../feedback-store"
}

inputs = {
  function_name         = "${local.base.project_name}-feedback-handler-${local.base.environment}"
  artefact_bucket_name  = local.base.artefact_bucket_name
  feedback_table_name   = dependency.feedback_store.outputs.feedback_table_name
  feedback_table_arn    = dependency.feedback_store.outputs.feedback_table_arn
} 