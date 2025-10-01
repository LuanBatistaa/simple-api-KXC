variable "secret_name" {
  description = "Nome do segredo"
  type        = string
}

variable "secret_value" {
  description = "Valor do segredo"
  type        = string
  sensitive   = true
}
