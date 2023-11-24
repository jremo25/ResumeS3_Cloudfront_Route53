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
resource "aws_lambda_function" "test_lambda" {
  filename         = "${path.module}/my_lambda_functions.zip"  
  function_name    = "lambda_function1"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda_function1.handler"  
  runtime          = "python3.8"

  environment {
    variables = {
      foo = "bar"
    }
  }
}



