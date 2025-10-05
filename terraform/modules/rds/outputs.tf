output "rds_address" {
  description = "Endpoint do RDS PostgreSQL"
  value       = aws_db_instance.this.address
}

output "rds_port" {
  description = "Porta do RDS"
  value       = aws_db_instance.this.port
  
}

output "rds_database" {
  description = "Nome do banco inicial"
  value       = aws_db_instance.this.db_name
}

output "rds_name" {
  description = "Nome do recurso RDS"
  value       = aws_db_instance.this.identifier
}
