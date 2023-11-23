data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}"
  output_path = "${path.module}/my_lambda_functions.zip"
  excludes    = ["*.tfstate", "*.tfstate.backup", ".terraform", ".terraform/*"] // exclude state files and .terraform directory
}


resource "aws_lambda_function" "test_lambda" {
  filename         = data.archive_file.lambda.output_path
  function_name    = "lambda_function1"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda_function1.handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "python3.8"

  environment {
    variables = {
      foo = "bar"
    }
  }
}


