data "aws_caller_identity" "current" {}

module "iam_iam-policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.17.0"
  name          = "rdb-custom-iam-user"
  policy = templatefile("policy.tftpl", {region=var.aws_region, account_id=data.aws_caller_identity.current.account_id, rds_resource_id=module.db_mysql.db_instance_resource_id,db_username=var.db_username})
}

module "iam_iam-assumable-role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.17.0"
  create_instance_profile= true
  create_role= true
  custom_role_policy_arns = [module.iam_iam-policy.arn]
  force_detach_policies = true
  role_description= "Custom Role To Connect to RDS"
  role_name = "rds-custom-iam-role"
  trusted_role_services = ["ec2.amazonaws.com"]
  role_requires_mfa = false
}