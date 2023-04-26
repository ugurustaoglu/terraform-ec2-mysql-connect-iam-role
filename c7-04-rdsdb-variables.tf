# AWS RDS Terraform Variables

variable "db_admin_username" {}
variable "db_username" {}
variable "db_identifier" {}
variable "db_name" {}
variable "db_size" {}
variable "db_port" {}
variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}
variable "db_password_length" {}