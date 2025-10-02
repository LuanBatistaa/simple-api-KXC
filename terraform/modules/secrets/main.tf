resource "random_password" "db" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "this" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.db.result
  })
}