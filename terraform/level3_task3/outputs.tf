output "kke_user_name" {
    value=aws_iam_user.derived-user.name
}

output "kke_role_name"{
    value=aws_iam_role.derived-role.name
}

output "kke_tags_applied"{
    value=aws_iam_user.derived-user.tags
}
