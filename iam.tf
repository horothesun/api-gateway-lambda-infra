resource "aws_iam_role" "lambda" {
  name = "${var.lambda_name}-lambda-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRole",
        "Principal" : { "Service" : "lambda.amazonaws.com" }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.id
  policy_arn = aws_iam_policy.lambda_cloudwatch.arn
}

resource "aws_iam_policy" "lambda_cloudwatch" {
  name   = "${var.lambda_name}-cloudwatch"
  policy = data.aws_iam_policy_document.lambda_cloudwatch.json
}

data "aws_iam_policy_document" "lambda_cloudwatch" {
  statement {
    sid    = "CreateCloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}
