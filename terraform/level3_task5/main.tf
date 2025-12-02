resource "aws_kms_key" "nautilus-key" {
  description             = "symmetric encryption KMS key"
  enable_key_rotation     = true
  deletion_window_in_days = 20
  tags = {
    name = "nautilus-kms-key"
  }
}

locals {
    sensitive_file=file("/home/bob/terraform/SensitiveData.txt")
}


resource "aws_kms_ciphertext" "encrypt" {
  key_id = aws_kms_key.nautilus-key.key_id
  plaintext = local.sensitive_file
}

resource "local_file" "encrypted_file" {
  filename = "/home/bob/terraform/EncryptedData.bin"
  content  = aws_kms_ciphertext.encrypt.ciphertext_blob
}

data "aws_kms_secrets" "decrypt" {
  secret {
    # ... potentially other configuration ...
    name    = "decrypt"
    payload = aws_kms_ciphertext.encrypt.ciphertext_blob
    key_id = aws_kms_key.nautilus-key.key_id
  }
}

resource "local_file" "decrypted_file" {
  filename = "/home/bob/terraform/EncryptedData.txt"
  content  = data.aws_kms_secrets.decrypt.plaintext["decrypt"]
}