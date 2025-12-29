output "kke_dynamodb_table" {
    value = aws_dynamodb_table.datacenter-table.name
}

output "kke_iam_role_name" {
    value = aws_iam_role.datacenter-role.name
}

output "kke_iam_policy_name" {
    value = aws_iam_policy.datacenter-policy.name
}