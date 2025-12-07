output "kke_api_gateway_names" {
    value = aws_api_gateway_rest_api.api_gateway[*].name
}

output "kke_log_group_names" {
    value = aws_cloudwatch_log_group.api_group[*].name
}