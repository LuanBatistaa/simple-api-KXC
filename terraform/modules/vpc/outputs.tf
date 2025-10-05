output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "vpc_endpoint_sg_id" {
  description = "Security Group ID do VPC Endpoint para ECR"
  value       = aws_security_group.vpc_endpoint_sg.id
}

output "vpc_cidr" {
  description = "CIDR block da VPC"
  value       = aws_vpc.this.cidr_block
}
