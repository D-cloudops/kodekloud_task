

locals {
    name-prefix="${var.KKE_PROJECT}-${var.KKE_TEAM}"
    common_tags = {
        Project=var.KKE_PROJECT
        Team=var.KKE_TEAM
        ManagedBy="Terraform"
        Env=var.KKE_ENVIRONMENT
    }
}

resource "aws_iam_user" "derived-user" {
  name = "${local.name-prefix}-user"
  tags = local.common_tags
}

resource "aws_iam_role" "derived-role" {
  name = "${local.name-prefix}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(local.common_tags, {
    RoleType = "EC2"
  })
}
