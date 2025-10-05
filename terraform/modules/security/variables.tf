variable "alb_name" {
  type = string

}

variable "vpc_id" {
  type = string

}

variable "ecs_name" {
  type = string

}

variable "alb_name" {
  type = string

}

variable "rds_name" {
  type = string

}

variable "container_name" {
  description = "Nome do container ECS"
  type        = string
}

variable "container_port" {
  description = "Porta que o container vai expor"
  type        = number
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}