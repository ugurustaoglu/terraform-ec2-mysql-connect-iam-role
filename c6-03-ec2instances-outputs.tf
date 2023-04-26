# AWS EC2 Instance Terraform Outputs

# Public EC2 Instances - Bastion Host
## ec2_bastion_public_instance_ids
output "ec2_bastion_host_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public_bastion_host[*].id
}

## ec2_bastion_public_ip
output "ec2_bastion_host_public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_public_bastion_host[*].public_ip
}

## ec2_private_instance_ids
output "ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_private[*].id
}

## ec2_private_instance_ips
output "ec2_private_instance_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_private[*].private_ip
}