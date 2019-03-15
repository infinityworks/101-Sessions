terraform {
  backend "s3" {
    bucket         = "YOUR BUCKET NAME HERE"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-remote-state-lock"
  }
}
