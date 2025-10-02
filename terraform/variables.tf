variable "aws_region" {
  description = "Região AWS"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "azs" {
  description = "Lista de zonas de disponibilidade"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs das subnets públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs das subnets privadas"
  type        = list(string)
}

variable "alb_name" {
  description = "Nome do load balancer"
  type = string
}

variable "secret_name" {
  description = "Nome do segredo no Secrets Manager"
  type        = string
  
}

variable "image_tag" {
  description = "Tag da imagem Docker a ser usada no ECS"
  type        = string
}

variable "rds_name" {
  description = "Nome do banco de dados RDS"
  type        = string
}




