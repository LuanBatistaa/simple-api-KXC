terraform {

  backend "s3" {
    bucket         = "my-bucket-state-kxc"
    key            = "simple-api/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
