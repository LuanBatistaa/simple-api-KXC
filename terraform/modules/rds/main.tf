# Security Group para o RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.rds_name}-sg"
<<<<<<< HEAD
  description = "Permite tráfego apenas da API"
=======
  description = "Permite trafego apenas da API"
>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
<<<<<<< HEAD
    security_groups = [module.ecs.ecs_sg_id] # Se você quiser referenciar SG do ECS
=======
    security_groups = [var.ecs_sg_id]
>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.rds_name}-sg"
  }
}

# Subnet Group
resource "aws_db_subnet_group" "this" {
  name       = "${var.rds_name}-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.rds_name}-subnet-group"
  }
}

# RDS PostgreSQL
resource "aws_db_instance" "this" {
  identifier              = var.rds_name
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
<<<<<<< HEAD
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
=======
  vpc_security_group_ids = [var.ecs_sg_id]
>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = true
  storage_encrypted       = true
  auto_minor_version_upgrade = true

  tags = {
    Name = var.rds_name
  }
}
