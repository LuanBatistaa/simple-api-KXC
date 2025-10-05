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



##########################

variable "alb_name" {
  description = "Nome do Application Load Balancer"
  type        = string
}


variable "db_username" {
  type        = string
  default     = "admin"
  description = "Nome do usuário do banco"
}

##########################

variable "image_tag" {
  description = "Tag da imagem Docker a ser usada no ECS"
  type        = string
}

variable "rds_name" {
  description = "Nome do banco de dados RDS"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados inicial"
  type        = string
}




