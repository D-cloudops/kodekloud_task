resource "aws_s3_bucket" "stream-bucket" {
  bucket = var.KKE_S3_BUCKET_NAME
}

resource "aws_iam_role" "firehose-role" {
  name = var.KKE_FIREHOSE_ROLE_NAME
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "firehose.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "firehose-policy" {
  name        = "firehose_s3_policy"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject"
      ],
      "Resource": aws_s3_bucket.stream-bucket.arn
    }
  ]
})
}

resource "aws_iam_role_policy_attachment" "firehose-attach" {
  role       = aws_iam_role.firehose-role.name
  policy_arn = aws_iam_policy.firehose-policy.arn
}

resource "aws_kinesis_firehose_delivery_stream" "fireshose-stream" {
  name        = var.KKE_FIREHOSE_STREAM_NAME
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose-role.arn
    bucket_arn = aws_s3_bucket.stream-bucket.arn
    buffering_size     = 5
    buffering_interval = 300
  

   processing_configuration {
      enabled = "true"

    processors {
        type = "AppendDelimiterToRecord"

        parameters {
            parameter_name = "Delimiter"
            parameter_value = "\n"

        }
   }
}
}
}



  


