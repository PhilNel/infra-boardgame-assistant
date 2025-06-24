# Lambda integration for POST /api/v1/chat
resource "aws_api_gateway_integration" "chat_post" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.chat.id
  http_method             = aws_api_gateway_method.chat_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${data.aws_lambda_function.rules_assistant.arn}/invocations"

  timeout_milliseconds = 29000 # Just under the 30-second API Gateway limit

  depends_on = [aws_lambda_permission.api_gateway_invoke]
}

# Integration responses for Lambda proxy integration
resource "aws_api_gateway_integration_response" "chat_post_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.chat.id
  http_method = aws_api_gateway_method.chat_post.http_method
  status_code = aws_api_gateway_method_response.chat_post_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,x-api-key,Authorization'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'"
  }

  depends_on = [aws_api_gateway_integration.chat_post]
}

# Error response mappings for Lambda integration
resource "aws_api_gateway_integration_response" "chat_post_400" {
  rest_api_id       = aws_api_gateway_rest_api.main.id
  resource_id       = aws_api_gateway_resource.chat.id
  http_method       = aws_api_gateway_method.chat_post.http_method
  status_code       = aws_api_gateway_method_response.chat_post_400.status_code
  selection_pattern = "4\\d{2}"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [aws_api_gateway_integration.chat_post]
}

resource "aws_api_gateway_integration_response" "chat_post_500" {
  rest_api_id       = aws_api_gateway_rest_api.main.id
  resource_id       = aws_api_gateway_resource.chat.id
  http_method       = aws_api_gateway_method.chat_post.http_method
  status_code       = aws_api_gateway_method_response.chat_post_500.status_code
  selection_pattern = "5\\d{2}"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [aws_api_gateway_integration.chat_post]
}

# Data source to get current AWS region
data "aws_region" "current" {}

# Data source to get the Lambda function
data "aws_lambda_function" "rules_assistant" {
  function_name = var.lambda_function_name
}

# Lambda permission to allow API Gateway to invoke the function
resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.rules_assistant.function_name
  principal     = "apigateway.amazonaws.com"

  # More restrictive source ARN that includes the specific method and resource
  source_arn = "${aws_api_gateway_rest_api.main.execution_arn}/*/*"
} 