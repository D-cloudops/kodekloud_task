KKE_ENV_TAGS = {
    dev = {
        bucket_name = "nautilus-dev-bucket-4177"
        tags = {
          Name = "nautilus-dev-bucket-4177"
          Environment = "Dev"
          Owner = "Alice"
        }
        backup = false
     
    }

    staging = {
        bucket_name = "nautilus-staging-bucket-4177"
        tags = {
          Name = "nautilus-staging-bucket-4177"
          Environment = "Staging"
          Owner = "Bob"
        }
        backup = true
    }

    prod = {
        bucket_name = "nautilus-prod-bucket-4177"
        tags = {
            Environment = "Prod"
            Owner = "Carol"
        }
        backup = true
    }
}