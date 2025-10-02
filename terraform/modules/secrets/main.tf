<<<<<<< HEAD
=======
resource "random_password" "db" {
  length  = 16
  special = true
}

>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
resource "aws_secretsmanager_secret" "this" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
<<<<<<< HEAD
  secret_string = var.secret_value
=======
  secret_string = jsonencode({
    username = var.username
    password = random_password.db.result
  })
>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
}