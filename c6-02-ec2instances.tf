# AWS EC2 Instance Terraform Module

# Bastion Host - EC2 Instance that will be created in VPC Public Subnet

module "ec2_public_bastion_host" {
  depends_on = [aws_key_pair.ec2-pem]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"
  count = length(module.vpc.public_subnets)
  name                   = "${var.environment}-Bastion-Host"
  ami                    = data.aws_ami.amz_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = module.vpc.public_subnets[count.index]
  vpc_security_group_ids = [module.sg_public_bastion_host.this_security_group_id]

  tags = local.common_tags
}

# Private Instances - EC2 Instances that will be used to connect to mysql db

module "ec2_private" {
  depends_on = [aws_key_pair.ec2-pem, module.db_mysql]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"
  count = length(module.vpc.private_subnets)

  name                   = "${var.environment}-Private-${count.index}"
  ami                    = data.aws_ami.amz_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              =  module.vpc.private_subnets[count.index]
  vpc_security_group_ids = [module.sg_private_ec2.this_security_group_id]
  iam_instance_profile   = module.iam_iam-assumable-role.iam_role_name
  user_data = <<-EOF
      #!/bin/bash
      sudo yum update -y
      sudo yum install mariadb wget python3  python3-pip -y
      cd ${var.ec2_home_path}
      sudo mysql -h ${module.db_mysql.db_instance_address} -u${var.db_admin_username} -p${random_password.master.result} -e "CREATE USER IF NOT EXISTS ${var.db_username} IDENTIFIED WITH AWSAuthenticationPlugin AS 'RDS';grant all privileges on ${var.db_name}.* to '${var.db_username}';"
      sudo wget -P ${var.ec2_home_path} https://s3.amazonaws.com/rds-downloads/rds-ca-2019-root.pem
      sudo python3 -m pip install -r ${var.ec2_home_path}/requirements.txt
      sudo python3 ${var.ec2_home_path}/test.py connect --endpoint=${module.db_mysql.db_instance_address} --user=${var.db_username} --port=${var.db_port}  --region=${var.aws_region} --dbname=${var.db_name}
    EOF
  tags = local.common_tags
}