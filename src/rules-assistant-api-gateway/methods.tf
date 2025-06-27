# =============================================================================
# POST /api/v1/chat - Main chat endpoint
# =============================================================================

resource "aws_api_gateway_method" "chat_post" {
  rest_api_id      = aws_api_gateway_rest_api.main.id
  resource_id      = aws_api_gateway_resource.chat.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

  request_validator_id = aws_api_gateway_request_validator.main.id

  request_models = {
    "application/json" = aws_api_gateway_model.chat_request.name
  }

  request_parameters = {
    "method.request.header.x-api-key" = true
  }
}

resource "aws_api_gateway_method_response" "chat_post_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.chat.id
  http_method = aws_api_gateway_method.chat_post.http_method
  status_code = "200"

  response_models = {
    "application/json" = aws_api_gateway_model.success_response.name
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

resource "aws_api_gateway_method_response" "chat_post_400" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.chat.id
  http_method = aws_api_gateway_method.chat_post.http_method
  status_code = "400"

  response_models = {
    "application/json" = aws_api_gateway_model.error_response.name
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "chat_post_401" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.chat.id
  http_method = aws_api_gateway_method.chat_post.http_method
  status_code = "401"

  response_models = {
    "application/json" = aws_api_gateway_model.error_response.name
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "chat_post_429" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.chat.id
  http_method = aws_api_gateway_method.chat_post.http_method
  status_code = "429"

  response_models = {
    "application/json" = aws_api_gateway_model.error_response.name
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Retry-After"                 = true
  }
}

resource "aws_api_gateway_method_response" "chat_post_500" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.chat.id
  http_method = aws_api_gateway_method.chat_post.http_method
  status_code = "500"

  response_models = {
    "application/json" = aws_api_gateway_model.error_response.name
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method" "chat_options" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.chat.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "chat_options_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.chat.id
  http_method = aws_api_gateway_method.chat_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Max-Age"       = true
  }
}

resource "aws_api_gateway_integration" "chat_options" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.chat.id
  http_method = aws_api_gateway_method.chat_options.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_integration_response" "chat_options_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.chat.id
  http_method = aws_api_gateway_method.chat_options.http_method
  status_code = aws_api_gateway_method_response.chat_options_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,x-api-key,Authorization'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,OPTIONS'"
    "method.response.header.Access-Control-Max-Age"       = "'86400'"
  }
}

# =============================================================================
# GET /api/v1/games - List available games
# =============================================================================

resource "aws_api_gateway_method" "games_get" {
  rest_api_id      = aws_api_gateway_rest_api.main.id
  resource_id      = aws_api_gateway_resource.games.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true

  request_parameters = {
    "method.request.header.x-api-key" = true
  }
}

resource "aws_api_gateway_method_response" "games_get_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.games.id
  http_method = aws_api_gateway_method.games_get.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

resource "aws_api_gateway_method" "games_options" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.games.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "games_options_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.games.id
  http_method = aws_api_gateway_method.games_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Max-Age"       = true
  }
}

resource "aws_api_gateway_integration" "games_options" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.games.id
  http_method = aws_api_gateway_method.games_options.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_integration_response" "games_options_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.games.id
  http_method = aws_api_gateway_method.games_options.http_method
  status_code = aws_api_gateway_method_response.games_options_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,x-api-key,Authorization'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Max-Age"       = "'86400'"
  }
}

# Mock integration for games endpoint (returns static list)
resource "aws_api_gateway_integration" "games_get" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.games.id
  http_method             = aws_api_gateway_method.games_get.http_method
  integration_http_method = "POST"
  type                    = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_integration_response" "games_get_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.games.id
  http_method = aws_api_gateway_method.games_get.http_method
  status_code = aws_api_gateway_method_response.games_get_200.status_code

  response_templates = {
    "application/json" = jsonencode({
      games = ["nemesis"]
      count = 1
    })
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,x-api-key,Authorization'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
  }

  depends_on = [
    aws_api_gateway_integration.games_get
  ]
}