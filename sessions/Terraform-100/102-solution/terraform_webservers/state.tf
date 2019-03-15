terraform {
  backend "s3" {
    bucket         = "YOUR BUCKET NAME HERE"
    key            = "terraform.tfstate/webservers"
    region         = "eu-west-1"
    dynamodb_table = "terraform-remote-state-lock"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  workspace = "${terraform.workspace}"

  config {
    bucket = "YOUR BUCKET NAME HERE"
    key    = "terraform.tfstate/vpc"
    region = "eu-west-1"
  }
}
