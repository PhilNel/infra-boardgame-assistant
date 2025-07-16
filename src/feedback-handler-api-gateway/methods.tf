# =============================================================================
# POST /api/v1/feedback - Feedback submission endpoint
# =============================================================================

resource "aws_api_gateway_method" "feedback_post" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.feedback.id
  http_method   = "POST"
  authorization = "NONE"

  request_validator_id = aws_api_gateway_request_validator.main.id

  request_models = {
    "application/json" = aws_api_gateway_model.feedback_request.name
  }
}

resource "aws_api_gateway_method_response" "feedback_post_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feedback.id
  http_method = aws_api_gateway_method.feedback_post.http_method
  status_code = "200"

  response_models = {
    "application/json" = aws_api_gateway_model.feedback_response.name
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

resource "aws_api_gateway_method_response" "feedback_post_400" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feedback.id
  http_method = aws_api_gateway_method.feedback_post.http_method
  status_code = "400"

  response_models = {
    "application/json" = aws_api_gateway_model.error_response.name
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

resource "aws_api_gateway_method_response" "feedback_post_500" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feedback.id
  http_method = aws_api_gateway_method.feedback_post.http_method
  status_code = "500"

  response_models = {
    "application/json" = aws_api_gateway_model.error_response.name
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

# =============================================================================
# OPTIONS /api/v1/feedback - CORS preflight
# =============================================================================

resource "aws_api_gateway_method" "feedback_options" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.feedback.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "feedback_options_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feedback.id
  http_method = aws_api_gateway_method.feedback_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Max-Age"       = true
  }
}

resource "aws_api_gateway_integration" "feedback_options" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feedback.id
  http_method = aws_api_gateway_method.feedback_options.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_integration_response" "feedback_options_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feedback.id
  http_method = aws_api_gateway_method.feedback_options.http_method
  status_code = aws_api_gateway_method_response.feedback_options_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,x-api-key,Authorization'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,OPTIONS'"
    "method.response.header.Access-Control-Max-Age"       = "'86400'"
  }
} 