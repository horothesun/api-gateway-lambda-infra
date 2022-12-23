resource "aws_cloudwatch_log_group" "lambda" {
  count = var.initial_setup ? 0 : 1

  name              = "/aws/lambda/${aws_lambda_function.lambda[0].function_name}"
  retention_in_days = var.lambda_logs_retention_days
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_cloudwatch_log_group" "api_gw" {
  count = var.initial_setup ? 0 : 1

  name              = "/aws/api_gw/${aws_apigatewayv2_api.api_gw[0].name}"
  retention_in_days = var.apigw_logs_retention_days
  lifecycle {
    prevent_destroy = false
  }
}
