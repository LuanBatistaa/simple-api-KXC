variable "secret_name" {
<<<<<<< HEAD
  description = "Nome do segredo"
  type        = string
}

variable "secret_value" {
  description = "Valor do segredo"
  type        = string
  sensitive   = true
}
=======
  type        = string
  description = "Nome do segredo no Secrets Manager"
}

variable "username" {
  type        = string
  description = "Nome de usuário do banco"
}

>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
