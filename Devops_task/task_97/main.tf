resource "aws_iam_policy" "ec2_readonly_policy" {
  name        = "iampolicy_mariyam"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:Get*",
          "ec2:Search*",
          "ec2:List*",
        ]
        Effect   = "Allow"
        Resource = "*"
      }]
})
}