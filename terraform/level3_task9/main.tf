resource "aws_secretsmanager_secret" "db_passwd" {
  name = var.SSM_NAME
}

resource "aws_secretsmanager_secret_version" "db_password_value" {
  secret_id     = aws_secretsmanager_secret.db_passwd.id
  secret_string = var.KKE_DB_PASSWORD
}
