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
    Component   = "feedback-store"
  }
}

resource "aws_dynamodb_table" "feedback_submissions" {
  name         = var.feedback_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "feedback_id"

  attribute {
    name = "feedback_id"
    type = "S"
  }

  attribute {
    name = "message_id"
    type = "S"
  }

  attribute {
    name = "game_name"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "N"
  }

  global_secondary_index {
    name     = "MessageIdIndex"
    hash_key = "message_id"

    projection_type = "ALL"
  }

  global_secondary_index {
    name      = "GameNameIndex"
    hash_key  = "game_name"
    range_key = "created_at"

    projection_type = "ALL"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = merge(local.common_tags, {
    Name = var.feedback_table_name
  })
}

 