# =============================================================================
# Lambda Integration for POST /api/v1/feedback
# =============================================================================

resource "aws_api_gateway_integration" "feedback_post" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feedback.id
  http_method = aws_api_gateway_method.feedback_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# =============================================================================
# Lambda Permission
# =============================================================================

resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.main.execution_arn}/*/*"
} 