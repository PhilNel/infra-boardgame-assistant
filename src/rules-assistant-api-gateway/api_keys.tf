# =============================================================================
# Usage Plans and API Keys
# =============================================================================

resource "aws_api_gateway_usage_plan" "free_tier" {
  name        = "${local.api_name}-free-tier"
  description = "Free tier usage plan for Board Game Assistant API"

  api_stages {
    api_id = aws_api_gateway_rest_api.main.id
    stage  = aws_api_gateway_stage.main.stage_name
  }

  quota_settings {
    limit  = var.free_tier_daily_quota
    period = "DAY"
  }

  throttle_settings {
    rate_limit  = var.api_throttle_rate_limit
    burst_limit = var.api_throttle_burst_limit
  }

  tags = local.tags
}