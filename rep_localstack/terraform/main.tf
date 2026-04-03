provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"

  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    lambda = "http://localhost:4566"
    sts    = "http://localhost:4566"
  }
}

resource "aws_lambda_function" "lambda" {
  function_name = "terraform-lambda"

  runtime = "python3.9"
  handler = "lambda_function.lambda_handler"

  filename         = "../function.zip"
  source_code_hash = filebase64sha256("../function.zip")

  role = "arn:aws:iam::000000000000:role/lambda-role"
}  
