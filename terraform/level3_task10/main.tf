resource "aws_api_gateway_rest_api" "api_gateway" {
  count = length(var.KKE_API_NAMES)
  name = "${terraform.workspace}-${var.KKE_API_NAMES[count.index]}"

   provisioner local-exec {
     command = "echo 'Created API Gateway '${self.name}' in workspace '${terraform.workspace}'' >> apigateway.log"
  }
}

resource "aws_cloudwatch_log_group" "api_group" {
  count = length(var.KKE_API_NAMES)
  name = "/aws/apigateway/${terraform.workspace}-${var.KKE_API_NAMES[count.index]}"

   provisioner local-exec {
     command = "echo 'Created Log Group '${self.name}' in workspace '${terraform.workspace}'' >> loggroups.log"
  }

}
