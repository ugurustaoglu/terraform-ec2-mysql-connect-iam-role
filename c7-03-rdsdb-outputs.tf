# AWS RDS Terraform Outputs


output "ec2_private_rds_instance_address" {
  description = "RDS DB instance address"
  value       = module.db_mysql.db_instance_address
}

output "ec2_private_rds_instance_arn" {
  description = "RDS DB instance arn"
  value       = module.db_mysql.db_instance_arn
}
