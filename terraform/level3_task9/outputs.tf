output "kke_secret_arn" {
    value = aws_secretsmanager_secret.db_passwd.arn
}

output "kke_secret_string" {
    value = aws_secretsmanager_secret_version.db_password_value.secret_string
    sensitive = true
}