remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "boardgame-assistant-terraform-state-bucket-eu-west-1"
    key            = "dev/${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "boardgame-assistant-terraform-locks"
  }
}

locals {
  aws_region           = "eu-west-1"
  artefact_bucket_name = "boardgame-assistant-artefacts-dev-eu-west-1"
  environment          = "dev"
  project_name         = "boardgame-assistant"
} 