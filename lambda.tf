resource "aws_lambda_function" "lambda" {
  count = var.initial_setup ? 0 : 1

  function_name = var.lambda_name
  role          = aws_iam_role.lambda.arn
  timeout       = local.http_timeout_in_seconds - 1
  memory_size   = var.lambda_memory_MB
  architectures = ["x86_64"]
  image_uri     = "${aws_ecr_repository.ecr_repo.repository_url}@${data.aws_ecr_image.ecr_image[0].id}"
  package_type  = "Image"
}
