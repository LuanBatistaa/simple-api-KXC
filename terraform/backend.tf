terraform {
  backend "s3" {
    bucket         = "meu-bucket-state-api"
    key            = "simple-api/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

