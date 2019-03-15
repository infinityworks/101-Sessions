variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "eu-west-1"
}

variable "iam_role" {
  description = "The AWS STS assume role used to execute Terraform"
  default     = ""
}

variable "bastion_public_key" {}

variable "workspace_iam_roles" {
  default = {
    development = ""
    production  = ""
  }
}

variable "bastion-amis" {
  description = "AMIs by region"

  default = {
    eu-west-1 = "ami-0fad7378adf284ce0"
  }
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "192.168.2.0/24"
}

variable "public_subnet_cidr_1a" {
  description = "CIDR for the Public Subnet"
  default     = "192.168.2.0/26"
}

variable "private_subnet_cidr_1a" {
  description = "CIDR for the Private Subnet"
  default     = "192.168.2.128/26"
}

variable "private_subnet_cidr_1b" {
  description = "CIDR for the Private Subnet"
  default     = "192.168.2.192/26"
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
