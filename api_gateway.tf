resource "aws_apigatewayv2_api" "api_gw" {
  count = var.initial_setup ? 0 : 1

  name          = aws_lambda_function.lambda[0].function_name
  protocol_type = "HTTP"
  description   = "HTTP API for ${aws_lambda_function.lambda[0].function_name}"

  cors_configuration {
    allow_credentials = false
    allow_headers     = []
    allow_methods     = [var.http_method]
    allow_origins     = ["*"]
    expose_headers    = []
    max_age           = 0
  }
}

resource "aws_apigatewayv2_stage" "default" {
  count = var.initial_setup ? 0 : 1

  api_id = aws_apigatewayv2_api.api_gw[0].id

  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw[0].arn

    format = jsonencode({
      request_id                = "$context.requestId"
      source_ip                 = "$context.identity.sourceIp"
      request_time              = "$context.requestTime"
      protocol                  = "$context.protocol"
      http_method               = "$context.httpMethod"
      resource_path             = "$context.resourcePath"
      route_key                 = "$context.routeKey"
      status                    = "$context.status"
      response_length           = "$context.responseLength"
      integration_error_message = "$context.integrationErrorMessage"
    })
  }

  default_route_settings {
    throttling_burst_limit = var.burst_limit_rps
    throttling_rate_limit  = var.rate_limit_rps
  }
}

resource "aws_apigatewayv2_integration" "lambda" {
  count = var.initial_setup ? 0 : 1

  api_id = aws_apigatewayv2_api.api_gw[0].id

  integration_uri        = aws_lambda_function.lambda[0].invoke_arn
  integration_type       = "AWS_PROXY"
  payload_format_version = "2.0"
  timeout_milliseconds   = 1000 * local.http_timeout_in_seconds
}

resource "aws_apigatewayv2_route" "lambda" {
  count = var.initial_setup ? 0 : 1

  api_id    = aws_apigatewayv2_api.api_gw[0].id
  route_key = "${var.http_method} ${var.http_route}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda[0].id}"
}

resource "aws_lambda_permission" "api_gw" {
  count = var.initial_setup ? 0 : 1

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda[0].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api_gw[0].execution_arn}/*/*"
}
