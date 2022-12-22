resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = var.lambda_logs_retention_days
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "/aws/api_gw/${aws_apigatewayv2_api.api_gw.name}"
  retention_in_days = var.apigw_logs_retention_days
  lifecycle {
    prevent_destroy = false
  }
}
