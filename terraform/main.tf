module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  aws_region = var.aws_region
}

module "alb" {
  source        = "./modules/alb"
  vpc_id        = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  alb_name      = var.alb_name
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "my-api"
}

module "ecs" {
  source               = "./modules/ecs"
  cluster_name         = "my-ecs-cluster"
  vpc_id               = module.vpc.vpc_id
  private_subnets      = module.vpc.private_subnets
  alb_target_group_arn = module.alb.alb_target_group_arn
  ecr_repository_url   = module.ecr.repository_url
  container_name       = "my-api"
  container_port       = 3000
  desired_count        = 2
  alb_sg_id            = module.alb.alb_sg_id
  image_tag            = var.image_tag
  vpc_cidr          = var.vpc_cidr
  api_port     = "3000"
  db_host      = module.rds.rds_address
  db_port      = "5432"
  db_database = module.rds.rds_database
  secret_arn   = module.secrets.secret_arn
  db_name = var.db_name
  rds_sg_id = module.rds.rds_sg_id
}


module "secrets" {
  source   = "./modules/secrets"
  secret_name = "my-db-secret"
  username    = var.secret_name
}

module "rds" {
  source               = "./modules/rds"
  rds_name             = "my-rds"
  db_instance_class    = "db.t3.micro"
  db_allocated_storage = 20
  vpc_id               = module.vpc.vpc_id
  private_subnets      = module.vpc.private_subnets
  db_username       = module.secrets.secret_value["username"]
  db_password       = module.secrets.secret_value["password"]
  ecs_sg_id          = module.ecs.ecs_sg_id
  db_name = var.db_name
  }


resource "aws_security_group_rule" "rds_ingress_from_ecs" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = module.rds.rds_sg_id        # Target: The RDS SG
  source_security_group_id = module.ecs.ecs_sg_id        # Source: The ECS SG
  description              = "Allow traffic from ECS API to RDS database"
}