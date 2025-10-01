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
