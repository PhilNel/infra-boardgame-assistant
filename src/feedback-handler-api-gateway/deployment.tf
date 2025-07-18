# =============================================================================
# API Gateway Deployment
# =============================================================================

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  depends_on = [
    aws_api_gateway_method.feedback_post,
    aws_api_gateway_method.feedback_options,
    aws_api_gateway_integration.feedback_post,
    aws_api_gateway_integration.feedback_options,
  ]

  triggers = {
    redeployment = sha256(jsonencode([
      aws_api_gateway_resource.api.id,
      aws_api_gateway_resource.v1.id,
      aws_api_gateway_resource.feedback.id,
      aws_api_gateway_method.feedback_post.id,
      aws_api_gateway_method.feedback_options.id,
      aws_api_gateway_integration.feedback_post.id,
      aws_api_gateway_integration.feedback_options.id,
      aws_api_gateway_method_response.feedback_post_200.id,
      aws_api_gateway_method_response.feedback_post_400.id,
      aws_api_gateway_method_response.feedback_post_500.id,
      aws_api_gateway_method_response.feedback_options_200.id,
      aws_api_gateway_integration_response.feedback_options_200.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# =============================================================================
# API Gateway Stage
# =============================================================================

resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = local.stage_name

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway.arn
    format = jsonencode({
      requestId      = "$context.requestId"
      ip             = "$context.identity.sourceIp"
      caller         = "$context.identity.caller"
      user           = "$context.identity.user"
      requestTime    = "$context.requestTime"
      httpMethod     = "$context.httpMethod"
      resourcePath   = "$context.resourcePath"
      status         = "$context.status"
      protocol       = "$context.protocol"
      responseLength = "$context.responseLength"
      errorMessage   = "$context.error.message"
      errorType      = "$context.error.messageString"
    })
  }

  xray_tracing_enabled = true

  tags = local.tags
}

# =============================================================================
# API Gateway Method Settings
# =============================================================================

resource "aws_api_gateway_method_settings" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  method_path = "*/*"

  settings {
    logging_level          = "INFO"
    data_trace_enabled     = true
    metrics_enabled        = true
    throttling_rate_limit  = 100
    throttling_burst_limit = 200
  }
} 