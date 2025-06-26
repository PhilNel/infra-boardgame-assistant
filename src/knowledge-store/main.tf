terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = "boardgame-assistant"
    Component   = "knowledge-store"
  }
}

resource "aws_dynamodb_table" "knowledge_chunks" {
  name         = var.knowledge_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "game_name"
  range_key    = "chunk_id"

  attribute {
    name = "game_name"
    type = "S"
  }

  attribute {
    name = "chunk_id"
    type = "S"
  }

  global_secondary_index {
    name     = "FilePathIndex"
    hash_key = "file_path"

    projection_type = "ALL"
  }

  attribute {
    name = "file_path"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(local.common_tags, {
    Name = var.knowledge_table_name
  })
}

resource "aws_dynamodb_table" "processing_jobs" {
  name         = var.jobs_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  global_secondary_index {
    name     = "GameNameIndex"
    hash_key = "game_name"

    projection_type = "ALL"
  }

  attribute {
    name = "game_name"
    type = "S"
  }

  global_secondary_index {
    name     = "StatusIndex"
    hash_key = "status"

    projection_type = "ALL"
  }

  attribute {
    name = "status"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(local.common_tags, {
    Name = var.jobs_table_name
  })
} 