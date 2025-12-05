resource "aws_s3_bucket" "multi_s3" {
  for_each = var.KKE_ENV_TAGS
  bucket = each.value.bucket_name
  lifecycle {
    ignore_changes = [tags]
  }
  tags =  each.value.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_life_rule" {
  for_each = { for k, v in var.KKE_ENV_TAGS : k => v if v.backup }
  bucket = aws_s3_bucket.multi_s3[each.key].id

  rule {
    id = "MoveToGlacier"
    status = "Enabled"
    filter{
      prefix = ""
    }
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  depends_on = [aws_s3_bucket.multi_s3]
  for_each = { for k, v in aws_s3_bucket.multi_s3 : k => v }
  bucket = aws_s3_bucket.multi_s3[each.key].id

  policy = jsonencode({
    Version = "2025-12-05"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.multi_s3[each.key].arn}/*"
        ]
      }
    ]
  })
}


resource "aws_s3_bucket_public_access_block" "block_public_access" {
  depends_on = [aws_s3_bucket.multi_s3]
  for_each = { for k, v in aws_s3_bucket.multi_s3 : k => v }
  bucket = aws_s3_bucket.multi_s3[each.key].id
  
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
