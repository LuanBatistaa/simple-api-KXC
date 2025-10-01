variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "public_subnets" {
  description = "IDs das subnets públicas onde o ALB ficará"
  type        = list(string)
}

variable "alb_name" {
  description = "Nome do Application Load Balancer"
  type        = string
  default     = "my-alb"
}

variable "alb_port" {
  description = "Porta do listener do ALB"
  type        = number
  default     = 80
}
