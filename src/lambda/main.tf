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

data "aws_s3_object" "rules_assistant" {
  bucket = var.artefact_bucket_name
  key    = "go-boardgame-rules-assistant.zip"
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

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "rules_assistant" {
  function_name = local.function_name
  role          = aws_iam_role.lambda_execution.arn
  handler       = "bootstrap"
  runtime       = "provided.al2"
  memory_size   = var.memory_size
  timeout       = var.timeout
  publish       = true

  s3_bucket         = data.aws_s3_object.rules_assistant.bucket
  s3_key            = data.aws_s3_object.rules_assistant.key
  s3_object_version = data.aws_s3_object.rules_assistant.version_id

  environment {
    variables = {
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