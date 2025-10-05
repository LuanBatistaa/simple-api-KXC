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
}

variable "db_name" {
  description = "Nome do banco de dados inicial"
  type        = string
}

variable "rds_sg_id" {
  description = "ID do security group para RDS"
  type        = string
}

variable "ecs_sg_id" {
  description = "ID do security group para ECS"
  type        = string
}

variable "db_username" {
  type        = string
  description = "Username do banco"
}

variable "db_password" {
  type        = string
  description = "Password do banco"
}