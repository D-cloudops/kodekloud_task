variable "KKE_ENV_TAGS" {
    type = map(object({
        bucket_name = string
        tags = map(string)
        backup = bool
    }))
}