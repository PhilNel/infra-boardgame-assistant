resource "aws_api_gateway_rest_api" "main" {
  name        = local.api_name
  description = "Board Game Rules Assistant API"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  # Enable request validation
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "execute-api:Invoke"
        Resource  = "*"
      }
    ]
  })

  tags = local.tags
}

resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "/aws/apigateway/${local.api_name}"
  retention_in_days = 30
  tags              = local.tags
}

resource "aws_iam_role" "api_gateway_cloudwatch" {
  name = "${local.api_name}-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "api_gateway_cloudwatch" {
  role       = aws_iam_role.api_gateway_cloudwatch.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_api_gateway_resource" "api" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "api"
}

resource "aws_api_gateway_resource" "v1" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.api.id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "chat" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "chat"
}

resource "aws_api_gateway_resource" "games" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "games"
}

resource "aws_api_gateway_request_validator" "main" {
  name                        = "${local.api_name}-validator"
  rest_api_id                 = aws_api_gateway_rest_api.main.id
  validate_request_body       = true
  validate_request_parameters = true
}

resource "aws_api_gateway_model" "chat_request" {
  rest_api_id  = aws_api_gateway_rest_api.main.id
  name         = "ChatRequest"
  content_type = "application/json"

  schema = jsonencode({
    type     = "object"
    required = ["gameName", "question"]
    properties = {
      gameName = {
        type      = "string"
        minLength = 1
        maxLength = 50
      }
      question = {
        type      = "string"
        minLength = 1
        maxLength = 1000
      }
      session_id = {
        type    = "string"
        pattern = "^[a-fA-F0-9-]{36}$"
      }
    }
  })
}

resource "aws_api_gateway_model" "success_response" {
  rest_api_id  = aws_api_gateway_rest_api.main.id
  name         = "SuccessResponse"
  content_type = "application/json"

  schema = jsonencode({
    type     = "object"
    required = ["answer"]
    properties = {
      answer = {
        type = "string"
      }
      session_id = {
        type = "string"
      }
      timestamp = {
        type   = "string"
        format = "date-time"
      }
    }
  })
}

resource "aws_api_gateway_model" "error_response" {
  rest_api_id  = aws_api_gateway_rest_api.main.id
  name         = "ErrorResponse"
  content_type = "application/json"

  schema = jsonencode({
    type     = "object"
    required = ["error"]
    properties = {
      error = {
        type = "string"
      }
      message = {
        type = "string"
      }
    }
  })
} 