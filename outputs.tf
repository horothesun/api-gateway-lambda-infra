output "ecr_repo_arn" {
  value = aws_ecr_repository.ecr_repo.arn
}

output "lambda_function_arn" {
  value = var.initial_setup ? "" : aws_lambda_function.lambda[0].arn
}
