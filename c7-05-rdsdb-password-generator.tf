# AWS Random Password Generator

resource "random_password" "master" {
    length          = var.db_password_length
    special         = false
}