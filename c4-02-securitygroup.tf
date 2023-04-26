# AWS Security Group Terraform Module


# Security Group for Public Bastion Host
module "sg_public_bastion_host" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name = "public-bastion-host-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = var.sg_bastion_host_ingress_rules
  ingress_cidr_blocks = var.sg_bastion_host_ingress_cidr_blocks

  # Egress Rule - all-all open
  egress_rules = var.sg_bastion_host_egress_rules
  tags = local.common_tags
}

# Security Group for Private EC2
module "sg_private_ec2" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name = "private-ec2-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = var.sg_ec2_ingress_rules
  ingress_cidr_blocks = var.sg_ec2_ingress_cidr_blocks
  # Egress Rule - all-all open
  egress_rules = var.sg_ec2_egress_rules
  tags = local.common_tags
}

# Security Group for private mysql
module "sg_private_mysql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name = "private-mysql-sg"
  description = "All deny"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = var.sg_mysql_ingress_rules
  ingress_cidr_blocks = var.sg_mysql_ingress_cidr_blocks
  # Egress Rule - all-all open
  egress_rules = var.sg_ec2_egress_rules
  tags = local.common_tags
}