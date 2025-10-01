terraform {
backend "s3" {
bucket = var.state_bucket
key = "terraform/state/ecs-fargate.tfstate"
region = var.aws_region
dynamodb_table = var.state_lock_table
encrypt = true
}
}
