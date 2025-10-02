output "secret_arn" {
  value = aws_secretsmanager_secret.this.arn
}

output "secret_value" {
  value = {
    username = var.username
    password = random_password.db.result
  }
}

