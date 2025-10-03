resource "aws_security_group" "rds_sg" {
  name        = "${var.rds_name}-sg"
  description = "Permite trafego apenas da API"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    
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

resource "aws_db_subnet_group" "this" {
  name       = "${var.rds_name}-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.rds_name}-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier           = var.rds_name
  engine               = "postgres"
  engine_version       = "17.6"
  instance_class       = var.db_instance_class
  allocated_storage    = var.db_allocated_storage
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = true
  storage_encrypted    = true
  auto_minor_version_upgrade = true
  db_name              = var.db_name
}