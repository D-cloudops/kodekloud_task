variable "KKE_ENVIRONMENT" {
    description="name of environment"
}

variable "KKE_KINESIS_STREAM_NAME"{
    description="Name of kinesis stream"
    nullable = false
}

variable "KKE_S3_BUCKET_NAME" {
    description="Name pf S3 bucket"
}