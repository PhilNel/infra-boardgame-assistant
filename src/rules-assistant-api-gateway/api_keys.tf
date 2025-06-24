# =============================================================================
# Usage Plans and API Keys
# =============================================================================

resource "aws_api_gateway_usage_plan" "free_tier" {
  name         = "${local.api_name}-free-tier"
  description  = "Free tier usage plan for Board Game Assistant API"

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

# =============================================================================
# API Key Support
# =============================================================================

data "aws_api_gateway_api_key" "manual_keys" {
  for_each = toset(var.manual_api_key_names)
  id       = each.value
}

resource "aws_api_gateway_usage_plan_key" "manual_free_tier" {
  for_each = var.manual_api_keys_usage_plan == "free" ? toset(var.manual_api_key_names) : []
  
  key_id        = each.value
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.free_tier.id
}