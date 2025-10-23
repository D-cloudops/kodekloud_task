variable "KKE_S3_BUCKET_NAME" {
    type=string
	description="Name of destination s3 bucket"
    default="devops-stream-bucket-196"
}

variable "KKE_FIREHOSE_STREAM_NAME" {
    type=string
	description="Name of firehose-stream"
    default="devops-firehose-stream"
}

variable "KKE_FIREHOSE_ROLE_NAME" {
    type=string
	descriptio="name of IAM role for firehose to stream into S3"
    default="firehose-sts-role"
}
