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
  function_name = var.function_name
}

data "aws_s3_object" "knowledge_processor" {
  bucket = var.artefact_bucket_name
  key    = "go-boardgame-knowledge-processor.zip"
}

resource "aws_iam_role" "lambda_execution" {
  name = "${local.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "s3_access" {
  name = "${local.function_name}-s3-access"
  role = aws_iam_role.lambda_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          var.knowledge_bucket_arn,
          "${var.knowledge_bucket_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "bedrock_access" {
  name        = "${local.function_name}-bedrock-access"
  description = "IAM policy for Lambda to invoke Bedrock models for embeddings"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "${local.function_name}-dynamodb-access"
  description = "IAM policy for Lambda to access DynamoDB tables"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem"
        ]
        Effect = "Allow"
        Resource = [
          var.knowledge_table_arn,
          var.jobs_table_arn,
          "${var.knowledge_table_arn}/*",
          "${var.jobs_table_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "bedrock_access" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = aws_iam_policy.bedrock_access.arn
}

resource "aws_iam_role_policy_attachment" "dynamodb_access" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_lambda_function" "knowledge_processor" {
  function_name = local.function_name
  role          = aws_iam_role.lambda_execution.arn
  handler       = "bootstrap"
  runtime       = "provided.al2"
  memory_size   = var.memory_size
  timeout       = var.timeout
  publish       = true

  s3_bucket         = data.aws_s3_object.knowledge_processor.bucket
  s3_key            = data.aws_s3_object.knowledge_processor.key
  s3_object_version = data.aws_s3_object.knowledge_processor.version_id

  environment {
    variables = {
      KNOWLEDGE_BUCKET_NAME      = var.knowledge_bucket_name
      KNOWLEDGE_TABLE_NAME       = var.knowledge_table_name
      JOBS_TABLE_NAME            = var.jobs_table_name
      BEDROCK_EMBEDDING_MODEL_ID = var.bedrock_embedding_model_id
      LOG_LEVEL                  = var.log_level
    }
  }

  tags = {
    Name = local.function_name
  }
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${local.function_name}"
  retention_in_days = 30
} 