<<<<<<< HEAD
variable "db_name" {
  
}

variable "db_username" {
  description = "Usuário mestre do RDS"
  type        = string
}

variable "db_password" {
  description = "Senha do usuário mestre"
  type        = string
  sensitive   = true
}
=======

>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6

variable "db_instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Tamanho do storage em GB"
  type        = number
  default     = 20
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "private_subnets" {
  description = "Lista de subnets privadas para RDS"
  type        = list(string)
}

variable "rds_name" {
  description = "Nome do recurso RDS"
  type        = string
  default     = "my-rds"
}
<<<<<<< HEAD
=======

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "ecs_sg_id" {
  description = "Security Group do ECS que terá acesso ao RDS"
  type        = string
}
>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
