# AWS Terraform Securıty Group Variables

# Security Group Bastion-Host Variables
sg_bastion_host_ingress_rules = ["ssh-tcp"]
sg_bastion_host_ingress_cidr_blocks = ["0.0.0.0/0"]
sg_bastion_host_egress_rules = ["all-all"]

# Security Group EC2 Variables
sg_ec2_ingress_rules = ["ssh-tcp","http-80-tcp","https-443-tcp"]
sg_ec2_ingress_cidr_blocks = ["0.0.0.0/0"]
sg_ec2_egress_rules = ["all-all"]

# Security Group RDS Variables
sg_mysql_ingress_rules = ["mysql-tcp"]
sg_mysql_ingress_cidr_blocks = ["0.0.0.0/0"]
sg_mysql_egress_rules = ["all-all"]