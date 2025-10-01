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
