# AWS Terraform VPC Variables

vpc_name = "myvpc"
vpc_cidr_block = "10.0.0.0/16"
vpc_azs = ["us-east-1a","us-east-1b"]
vpc_public_subnets = ["10.0.101.0/24"]
vpc_private_subnets = ["10.0.1.0/24","10.0.2.0/24"]
vpc_database_subnets = ["10.0.3.0/24","10.0.4.0/24"]
vpc_enable_nat_gateway = true
vpc_single_nat_gateway = true
vpc_enable_dns_hostnames = true
vpc_enable_dns_support = true
vpc_tag_public_subnets = "Public Subnet"
vpc_tag_private_subnets = "Private Subnet"
vpc_tag_database_subnets = "Private Database Subnet"
vpc_create_database_subnet_group = true
aws_region     = "us-east-1"