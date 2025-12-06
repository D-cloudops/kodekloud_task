variable "bucket_named" {
    type = string
}

variable "index_document" {
    type = string 
    description = "Index document of static file"
    default = "index.html"
}
