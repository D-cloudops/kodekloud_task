resource "aws_dynamodb_table" "devops-app-table" {
  name           = var.KKE_DYNAMODB_TABLE_NAME
  billing_mode   = "PAY_PER_REQUEST"
  hash_key         = "TestTableHashKey"
  
  attribute {
    name = "TestTableHashKey"
    type = "S"
  }
}

resource "aws_sns_topic" "devops-app-topic" {
  name = var.KKE_SNS_TOPIC_NAME
  }

resource "aws_ssm_parameter" "devops_ssm" {
  name  = var.KKE_SSM_PARAM_NAME
  type  = "SecureString"
  value = var.KKE_DYNAMODB_TABLE_NAME
}