output "ecr_repo_arn" {
  value = aws_ecr_repository.ecr_repo.arn
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda.arn
}
