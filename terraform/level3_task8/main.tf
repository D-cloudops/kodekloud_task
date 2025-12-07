module "s3_bucket_create" {
    source = "./modules/s3-static-site"
    bucket_name = var.bucket_named
}

resource "aws_s3_object" "copying_index_files" {
  bucket =  module.s3_bucket_create.bucket_name
  key    =  var.index_document
  source = "./index.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./index.html")
}