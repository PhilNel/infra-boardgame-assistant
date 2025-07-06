locals {
  use_custom_domain = var.custom_domain_name != "" && var.hosted_zone_id != "" && var.certificate_arn != ""
}

resource "aws_api_gateway_domain_name" "api" {
  count                   = local.use_custom_domain ? 1 : 0
  domain_name             = var.custom_domain_name
  regional_certificate_arn = var.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = merge(local.tags, {
    Name = var.custom_domain_name
  })
}

resource "aws_api_gateway_base_path_mapping" "api" {
  count       = local.use_custom_domain ? 1 : 0
  api_id      = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  domain_name = aws_api_gateway_domain_name.api[0].domain_name
} 