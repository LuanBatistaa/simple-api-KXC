variable "vpc_cidr" {
  description = "CIDR block da VPC"
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

variable "aws_region" {
  description = "região aws"
}

variable "vpc_endpoint_sg_id" {
  type        = string
  description = "Security Group ID dos VPC endpoints (Secrets e ECR)"
}
