variable "vpc_cidr" {}

variable "public_subnet_cidr_1a" {}

variable "private_subnet_cidr_1a" {}

variable "private_subnet_cidr_1b" {}

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
