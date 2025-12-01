resource "aws_kinesis_stream" "datacenter_stream" {
  name             = var.KKE_KINESIS_STREAM_NAME
  shard_count      = 1
  retention_period = 24
  tags = {
     Environment="dev"
     Purpose="Stream ingestion"
  }
  provisioner "local-exec" {
    command = "echo 'Kinesis Stream devops-dev-stream created' > kinesis_creation.log"
  }
}

resource "aws_s3_bucket" "stream_bucket" {
  bucket = var.KKE_S3_BUCKET_NAME

  tags = {
    Environment="dev"
    Owner="devops"
  }

  provisioner "local-exec" {
    command = "echo 'S3 Bucket ${aws_s3_bucket.stream_bucket.id} created' > s3_creation.log"
  }
}

data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

resource "local_file" "account_identity_log" {
  filename = "account_identity.log"
  content  = "Logged in as account ID:${local.account_id}"
}

