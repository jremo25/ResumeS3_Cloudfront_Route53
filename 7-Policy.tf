data "aws_dynamodb_table" "my_table" {
  name = "my-dynamodb-table"
  depends_on = [aws_dynamodb_table.my_table]
}

data "aws_iam_policy_document" "lambda_dynamodb_access_policy" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:PutItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeTable",
      "dynamodb:ConditionCheckItem",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [data.aws_dynamodb_table.my_table.arn]
  }
}
