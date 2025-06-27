include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../src//rules-assistant-api-gateway"
}

dependency "rules_assistant_lambda" {
  config_path = "../rules-assistant-lambda"
  
  mock_outputs = {
    function_name = "dev-boardgame-assistant-rules-assistant-lambda"
  }
}

inputs = {
  environment = "dev"
  lambda_function_name = dependency.rules_assistant_lambda.outputs.function_name
  
  allowed_origins = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
  ]
  
  enable_request_response_logging = true
} 