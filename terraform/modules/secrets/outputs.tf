output "secret_arn" {
  value = aws_secretsmanager_secret.this.arn
}
<<<<<<< HEAD
=======

output "secret_value" {
  value = {
    username = var.username
    password = random_password.db.result
  }
}


>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
