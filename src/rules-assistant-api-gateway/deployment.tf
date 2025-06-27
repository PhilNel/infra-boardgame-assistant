resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  # Force redeployment when any method changes
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.api.id,
      aws_api_gateway_resource.v1.id,
      aws_api_gateway_resource.chat.id,
      aws_api_gateway_resource.games.id,
      aws_api_gateway_method.chat_post.id,
      aws_api_gateway_method.chat_options.id,
      aws_api_gateway_method.games_get.id,
      aws_api_gateway_method.games_options.id,
      aws_api_gateway_integration.chat_post.id,
      aws_api_gateway_integration.chat_options.id,
      aws_api_gateway_integration.games_get.id,
      aws_api_gateway_integration.games_options.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_method.chat_post,
    aws_api_gateway_method.chat_options,
    aws_api_gateway_method.games_get,
    aws_api_gateway_method.games_options,
    aws_api_gateway_integration.chat_post,
    aws_api_gateway_integration.chat_options,
    aws_api_gateway_integration.games_get,
    aws_api_gateway_integration.games_options,
  ]
}

resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = local.stage_name

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_access.arn
    format = jsonencode({
      requestId        = "$context.requestId"
      requestTime      = "$context.requestTime"
      httpMethod       = "$context.httpMethod"
      resourcePath     = "$context.resourcePath"
      status           = "$context.status"
      protocol         = "$context.protocol"
      responseLength   = "$context.responseLength"
      responseTime     = "$context.responseTime"
      sourceIp         = "$context.identity.sourceIp"
      userAgent        = "$context.identity.userAgent"
      apiKeyId         = "$context.identity.apiKeyId"
      error            = "$context.error.message"
      integrationError = "$context.integration.error"
    })
  }

  xray_tracing_enabled = false

  tags = local.tags
}

resource "aws_cloudwatch_log_group" "api_gateway_access" {
  name              = "/aws/apigateway/${local.api_name}/access"
  retention_in_days = 30
  tags              = local.tags
}

resource "aws_api_gateway_method_settings" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true

    logging_level = var.api_gateway_log_level

    data_trace_enabled = var.enable_request_response_logging

    throttling_rate_limit  = var.stage_throttle_rate_limit
    throttling_burst_limit = var.stage_throttle_burst_limit

    caching_enabled      = false
    cache_ttl_in_seconds = 0
  }
}