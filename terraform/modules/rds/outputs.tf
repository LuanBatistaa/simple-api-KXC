output "rds_endpoint" {
  description = "Endpoint do RDS PostgreSQL"
  value       = aws_db_instance.this.endpoint
}

output "rds_port" {
  description = "Porta do RDS"
  value       = aws_db_instance.this.port
}

output "rds_sg_id" {
  description = "Security Group do RDS"
  value       = aws_security_group.rds_sg.id
}