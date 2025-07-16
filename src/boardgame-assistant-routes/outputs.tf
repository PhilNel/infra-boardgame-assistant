output "website_record_fqdn" {
  description = "FQDN of the website DNS record (chat.boardgamewarlock.com)"
  value       = var.website_cloudfront_domain_name != "" ? aws_route53_record.website[0].fqdn : null
}

output "api_record_fqdn" {
  description = "FQDN of the API Gateway DNS record (api.boardgamewarlock.com)"
  value       = var.api_regional_domain_name != "" ? aws_route53_record.api[0].fqdn : null
}

output "feedback_api_record_fqdn" {
  description = "FQDN of the Feedback API Gateway DNS record (feedback.boardgamewarlock.com)"
  value       = var.feedback_api_regional_domain_name != "" ? aws_route53_record.feedback_api[0].fqdn : null
}