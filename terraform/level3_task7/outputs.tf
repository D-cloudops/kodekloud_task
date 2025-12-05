output "kke_bucket_names" {
    value = [ for k in aws_s3_bucket.multi_s3 : k.id ]
}