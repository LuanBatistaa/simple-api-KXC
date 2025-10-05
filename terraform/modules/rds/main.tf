# resource "aws_security_group" "rds_sg" {
#   name        = "${var.rds_name}-sg"
#   description = "Permite trafego apenas da API"
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port       = 5432
#     to_port         = 5432
#     protocol        = "tcp"
#     security_groups = [var.ecs_sg_id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.rds_name}-sg"
#   }
# }

resource "aws_db_subnet_group" "this" {
  name       = "${var.rds_name}-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.rds_name}-subnet-group"
  }
}

data "aws_secretsmanager_secret_version" "db_secret" {
  secret_id = var.db_secret_arn
}

resource "aws_db_instance" "this" {
  identifier              = var.rds_name
  engine                  = "postgres"
  engine_version          = "17.6"
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  username                = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)["username"]
  password                = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)["password"]
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = true
  storage_encrypted       = true
  auto_minor_version_upgrade = true
  db_name = var.db_name

  tags = {
    Name = var.rds_name
  }
}

