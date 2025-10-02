terraform {
<<<<<<< HEAD
backend "s3" {
bucket = var.state_bucket
key = "terraform/state/ecs-fargate.tfstate"
region = var.aws_region
dynamodb_table = var.state_lock_table
encrypt = true
}
}
=======
  backend "s3" {
    bucket         = "my-bucket-state-api"
    key            = "simple-api/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6
