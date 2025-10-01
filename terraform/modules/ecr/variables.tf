variable "repository_name" {
  description = "Nome do repositório ECR"
  type        = string
}

variable "scan_on_push" {
  description = "Ativa ou não o scan de vulnerabilidades ao enviar imagem"
  type        = bool
  default     = true
}
