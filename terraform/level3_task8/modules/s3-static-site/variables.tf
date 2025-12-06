variable "bucket_name"{
    type = string
    description = "Name of the bucket"
}

variable "index_document" {
    type = string 
    description = "Index document of static file"
    default = "index.html"
}

