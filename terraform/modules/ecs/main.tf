resource "aws_security_group" "ecs_sg" {
  name        = "${var.cluster_name}-sg"
  description = "Permite trafego apenas do ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

#   egress {
#   from_port   = 5432
#   to_port     = 5432
#   protocol    = "TCP"
#   security_groups = [var.rds_sg_id]
# }
  tags = {
    Name = "${var.cluster_name}-sg"
  }
}

resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.cluster_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

 execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = var.container_name
    image     = "${var.ecr_repository_url}:${var.image_tag}"
    essential = true
    portMappings = [
      { containerPort = var.container_port, hostPort = var.container_port }
    ]
    environment = [
      { name = "API_PORT", value = var.api_port },
      { name = "DB_HOST", value = var.db_host },
      { name = "DB_PORT", value = var.db_port },
      { name = "DB_DATABASE", value = var.db_database }
    ]
    secrets = [
      {
        name      = "DB_USER"
        valueFrom = "${var.secret_arn}:username::"
      },
      {
        name      = "DB_PASSWORD"
        valueFrom = "${var.secret_arn}:password::"
      }
    ]
 }])
}


resource "aws_ecs_service" "this" {
  name            = "${var.cluster_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
