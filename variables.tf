# required parameters

variable "lambda_name" {
  description   = "Lambda and ECR repo name."
  type        = string
}

variable "lambda_memory_MB" {
  description = "Lambda memory in MB."
  type        = number
}

variable "lambda_logs_retention_days" {
  description = "Lambda CloudWatch logs retention in days."
  type        = number
}

variable "http_method" {
  description = "HTTP method used to call the lambda triggering endpoint. (e.g. \"GET\")"
  type        = string
}

variable "http_route" {
  description = "HTTP route used to call the lambda triggering endpoint. (e.g. \"/pets\")"
  type        = string
}

variable "http_timeout_seconds" {
  description = "HTTP timeout in seconds. The underlying lambda times-out 1s earlier."
  type        = number

  validation {
    condition     = var.http_timeout_seconds >= 2 && var.http_timeout_seconds <= 30
    error_message = "The http_timeout_seconds value must be in at least 2 and no more than 30."
  }
}

variable "apigw_logs_retention_days" {
  description = "API Gateway logs retention in days."
  type        = number
}

# optional parameters

variable "burst_limit_rps" {
  description = "Default throttling burst limit for all routes in rps."
  type        = number
  default     = 1
}

variable "rate_limit_rps" {
  description = "Default throttling rate limit for all routes in rps."
  type        = number
  default     = 1
}
