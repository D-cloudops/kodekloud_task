resource "aws_s3_bucket" "s3_bucket_creation" {
  bucket = var.bucket_name
  
  tags = {
    Project = "StaticWeb"
  }
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.s3_bucket_creation.id

  index_document {
    suffix = var.index_document
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_acess" {
  bucket = aws_s3_bucket.s3_bucket_creation.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
