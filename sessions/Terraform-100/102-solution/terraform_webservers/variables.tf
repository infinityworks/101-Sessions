variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "eu-west-1"
}

variable "iam_role" {
  description = "The AWS STS assume role used to execute Terraform"
  default     = ""
}

variable "workspace_iam_roles" {
  default = {
    development = ""
    production  = ""
  }
}

variable "cluster_name" {
  description = "The name for the webservers cluster"
  default     = "WebserverCluster"
}

# TAGS
variable "workspace_tags_project" {
  default = {
    development = "iw-100-training"
    production  = "iw-100-training"
  }
}

variable "workspace_tags_costcentre" {
  default = {
    development = "DEV_COSTCENTRE"
    production  = "PROD_COSTCENTRE"
  }
}

locals {
  common_tags = {
    project     = "${var.workspace_tags_project[terraform.workspace]}"
    costcentre  = "${var.workspace_tags_costcentre[terraform.workspace]}"
    environment = "${terraform.workspace}"
  }
}
