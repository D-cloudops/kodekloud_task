output "kke_dynamodb_table_name"{
    value=aws_dynamodb_table.devops-app-table.name
}

output "kke_sns_topic_arn" {
    value=aws_sns_topic.devops-app-topic.arn
}

output "kke_ssm_parameter_name"{
   value=aws_ssm_parameter.devops_ssm.name
}