variable "cluster_name" {
  description = "Nome do ECS Cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "private_subnets" {
  description = "Lista de subnets privadas para ECS Tasks"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ARN do Target Group do ALB"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL do repositório ECR"
  type        = string
}

variable "container_name" {
  description = "Nome do container ECS"
  type        = string
}

variable "container_port" {
  description = "Porta que o container vai expor"
  type        = number
  default     = 3000
}

variable "desired_count" {
  description = "Número de tasks ECS"
  type        = number
  default     = 2
}

variable "alb_sg_id" {
  type        = string
  description = "ID do security group do ALB"
}

variable "image_tag" {
  description = "Tag da imagem Docker que será usada no ECS"
  type        = string
  default     = "latest"
}
variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "rds_name" {
  description = "Nome do banco de dados RDS"
  type        = string
}

variable "db_host" {
  type = string
}

variable "db_user_arn" {
  type = string
}

variable "db_password_arn" {
  type = string
}
