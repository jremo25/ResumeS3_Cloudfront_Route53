resource "aws_dynamodb_table" "my_table" {
  name           = "my-dynamodb-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "views"
    type = "N"
  }

  global_secondary_index {
    name               = "views-index"
    hash_key           = "id"      // The same as the table's hash key
    range_key          = "views"   // 'views' is now the range key for the index
    write_capacity     = 1
    read_capacity      = 1

    projection_type    = "ALL" // Using 'ALL' since no specific non-key attributes were specified
  }
}

resource "aws_dynamodb_table_item" "example_item" {
  table_name = aws_dynamodb_table.my_table.name
  hash_key   = "id"

  item = <<ITEM
{
  "id": {"S": "0"},
  "views": {"N": "1"}
}
ITEM
}

