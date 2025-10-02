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
<<<<<<< HEAD
=======

variable "secret_name" {
  description = "Nome do segredo no Secrets Manager"
  type        = string
  
}

variable "image_tag" {
  description = "Tag da imagem Docker a ser usada no ECS"
  type        = string
}



>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
