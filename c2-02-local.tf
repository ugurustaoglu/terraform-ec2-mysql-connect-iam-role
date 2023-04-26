# Local Variables For Terraform Reference
locals {
  owners = var.business_division
  environment = var.environment
  app_name = var.app_name
  name = "${var.business_division}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
}

