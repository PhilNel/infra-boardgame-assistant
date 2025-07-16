resource "aws_api_gateway_rest_api" "main" {
  name        = local.api_name
  description = "Board Game Feedback API"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

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

resource "aws_api_gateway_resource" "feedback" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "feedback"
}

resource "aws_api_gateway_request_validator" "main" {
  name                        = "${local.api_name}-validator"
  rest_api_id                 = aws_api_gateway_rest_api.main.id
  validate_request_body       = true
  validate_request_parameters = true
}

resource "aws_api_gateway_model" "feedback_request" {
  rest_api_id  = aws_api_gateway_rest_api.main.id
  name         = "FeedbackRequest"
  content_type = "application/json"

  schema = jsonencode({
    type     = "object"
    required = ["message_id", "game_name", "feedback_type", "timestamp"]
    properties = {
      message_id = {
        type      = "string"
        minLength = 1
        maxLength = 100
      }
      game_name = {
        type      = "string"
        minLength = 1
        maxLength = 50
      }
      feedback_type = {
        type = "string"
        enum = ["positive", "negative"]
      }
      user_hash = {
        type      = "string"
        maxLength = 64
      }
      issues = {
        type = "array"
        items = {
          type = "string"
          enum = ["incorrect_info", "missing_info", "unclear", "wrong_game", "other"]
        }
        maxItems = 5
      }
      description = {
        type      = "string"
        maxLength = 256
      }
      conversation_context = {
        type = "object"
        properties = {
          recent_qa = {
            type = "array"
            items = {
              type = "object"
              properties = {
                question = {
                  type      = "string"
                  maxLength = 500
                }
                answer = {
                  type      = "string"
                  maxLength = 5000
                }
                timestamp = {
                  type   = "string"
                  format = "date-time"
                }
              }
            }
            maxItems = 10
          }
        }
      }
      timestamp = {
        type   = "string"
        format = "date-time"
      }
    }
  })
}

resource "aws_api_gateway_model" "feedback_response" {
  rest_api_id  = aws_api_gateway_rest_api.main.id
  name         = "FeedbackResponse"
  content_type = "application/json"

  schema = jsonencode({
    type     = "object"
    required = ["feedback_id", "message"]
    properties = {
      feedback_id = {
        type = "string"
      }
      message = {
        type = "string"
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