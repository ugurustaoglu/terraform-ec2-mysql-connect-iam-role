# AWS Terraform RDS Instances Variables

db_admin_username = "testadmin"
db_username = "testuser"
db_password = "" # password has to be at least 8 character long
db_identifier = "testdb"  # The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier
db_name = "testdb" # The DB name to create.
db_size = 5 # Size in GB
db_port = 3306 # Size in GB
db_password_length = 10