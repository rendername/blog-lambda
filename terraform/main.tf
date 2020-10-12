provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
  profile = "your-local-aws-profile"
}

resource "aws_iam_role" "hello_function_role" {
  name = "hello_function_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "hello_function" {
  filename = "../publish/${var.published_source}"
  function_name = "hello_function"
  role = aws_iam_role.hello_function_role.arn
  handler = "hello_function.hello"
  source_code_hash = filebase64sha256("../publish/${var.published_source}")
  runtime = "python3.6"
  environment {
    variables = {
      NAME = var.name
    }
  }
}