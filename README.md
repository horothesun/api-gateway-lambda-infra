# API Gateway triggered Lambda infrastructure

[![CI](https://github.com/horothesun/api-gateway-lambda-infra/actions/workflows/ci.yml/badge.svg)](https://github.com/horothesun/api-gateway-lambda-infra/actions/workflows/ci.yml)

## Code template

[horothesun/api-gateway-lambda-cookiecutter-template](https://github.com/horothesun/api-gateway-lambda-cookiecutter-template)

## Usage

```terraform
module "demo_api_gateway_lambda" {
  source = "github.com/horothesun/api-gateway-lambda-infra?ref=1.0.0"

  lambda_name                = "demo-api-gateway-lambda"
  lambda_memory_MB           = 512
  lambda_logs_retention_days = 7
  http_method                = "GET"
  http_route                 = "/time"
  http_timeout_seconds       = 30
  apigw_logs_retention_days  = 7
  burst_limit_rps            = 1
  rate_limit_rps             = 1
  initial_setup              = true # TODO: remove once a 'latest' tagged ECR image is available
}
```
