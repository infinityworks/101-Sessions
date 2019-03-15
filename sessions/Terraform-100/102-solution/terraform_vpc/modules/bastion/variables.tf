variable "ami" {}

variable "vpc_cidr" {}

variable "aws_region" {}

variable "bastion_public_key" {}

variable "public_sn_id" {}

variable "private_subnet_cidr_1a" {}

variable "private_subnet_cidr_1b" {}

variable "vpc_id" {}

# TAGS
variable "workspace_tags_project" {}

variable "workspace_tags_costcentre" {}

locals {
  common_tags = {
    project     = "${var.workspace_tags_project}"
    costcentre  = "${var.workspace_tags_costcentre}"
    environment = "${terraform.workspace}"
  }
}
