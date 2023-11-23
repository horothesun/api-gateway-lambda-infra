# API Gateway triggered Lambda infrastructure

[![CI](https://github.com/horothesun/api-gateway-lambda-infra/actions/workflows/ci.yml/badge.svg)](https://github.com/horothesun/api-gateway-lambda-infra/actions/workflows/ci.yml)

## Code template

[horothesun/api-gateway-lambda-template.g8](https://github.com/horothesun/api-gateway-lambda-template.g8)

## Setup

- Add the following block to your infrastructure code

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
  initial_setup              = true # TO BE REMOVED once the first ECR image gets created!
}
```

- Make sure your AWS OIDC for GitHub workflows role only contains permissions referencing
  `ecr_repo_arn` and NOT `lambda_function_arn`.
- Apply the Terraform changes.
- Run the service CI pipeline to publish the first ECR image
  (the pipeline will fail at the "Update lambda" stage).
- Remove `initial_setup` from your configuration (defaulting it to `false`).
- Update your AWS OIDC for GitHub workflows role by adding the permission
  referencing `lambda_function_arn` as well.
- Apply the Terraform changes again.
- Run the service CI pipeline again to update the lambda with the latest ECR image.
