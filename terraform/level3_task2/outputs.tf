
output "kke_firehose_stream_name" {
    value=aws_kinesis_firehose_delivery_stream.fireshose-stream.name
}

output "kke_s3_bucket_name" {
    value=aws_s3_bucket.stream-bucket.id
}

output "kke_firehose_role_arn" {
    value=aws_iam_role.firehose-role.arn
}