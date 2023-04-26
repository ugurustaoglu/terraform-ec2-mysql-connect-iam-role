resource "null_resource" "name" {
  depends_on = [module.ec2_public_bastion_host]
  count = length(module.ec2_public_bastion_host[*].public_ip)
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = module.ec2_public_bastion_host[count.index].public_ip
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/ec2-key.pem")
  }

  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "private-key/ec2-key.pem"
    destination = "/tmp/ec2-key.pem"
  }

}

resource "null_resource" "remote" {
  depends_on = [module.ec2_private, module.vpc]
  count = length(module.ec2_private[*].public_ip)
  # Connection Block for Provisioners to connect to EC2 Instance

  connection {
      agent               = "true"
      bastion_host        = module.ec2_public_bastion_host[0].public_ip
      bastion_user        = "ec2-user"
      bastion_port        = 22
      bastion_private_key = file("private-key/ec2-key.pem")
      user                = "ec2-user"
      private_key         = file("private-key/ec2-key.pem")
      host                = module.ec2_private[count.index].private_ip
    }

  provisioner "file" {
    source      = "scripts/"
    destination = var.ec2_home_path
  }

}
