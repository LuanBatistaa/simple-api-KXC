module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
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
}

module "rds" {
  source          = "./modules/rds"
  db_name         = "mydb"
  db_username     = "admin"
  db_password     = "SuperSecret123!" # ou usar variável sensitive
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  rds_name        = "my-rds"
}
