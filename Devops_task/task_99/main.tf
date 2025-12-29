resource "aws_dynamodb_table" "datacenter-table" {
  name           = var.KKE_TABLE_NAME
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_iam_role" "datacenter-role" {
  name = var.KKE_ROLE_NAME

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "datacenter-policy" {
  name        = var.KKE_POLICY_NAME
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:Scan",
        "dynamodb:Query"
      ],
      "Resource": aws_dynamodb_table.datacenter-table.arn
    }
  ]
})
}

resource "aws_iam_policy_attachment" "datacenter-attach" {
  name       = "datacenter-attachment"
  roles      = [aws_iam_role.datacenter-role.name]
  policy_arn = aws_iam_policy.datacenter-policy.arn
}