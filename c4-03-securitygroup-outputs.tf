# AWS Terraform Securıty Group Outputs

output "security_group_bastion_host_group_id" {
  description = "The ID of the bastion host security group"
  value       = try(module.sg_public_bastion_host.this_security_group_id, "")
}

output "security_group_ec2_group_id" {
  description = "The ID of the EC2 security group"
  value       = try(module.sg_private_ec2[*].this_security_group_id, "")
}

output "security_group_rds_group_id" {
  description = "The ID of the RDS security group"
  value       = try(module.sg_private_mysql.this_security_group_id, "")
}
