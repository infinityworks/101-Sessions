module "vpc" {
  source                    = "./vpc"
  private_subnet_cidr_1a    = "${var.private_subnet_cidr_1a}"
  private_subnet_cidr_1b    = "${var.private_subnet_cidr_1b}"
  public_subnet_cidr_1a     = "${var.public_subnet_cidr_1a}"
  vpc_cidr                  = "${var.vpc_cidr}"
  workspace_tags_project    = "${var.workspace_tags_project[terraform.workspace]}"
  workspace_tags_costcentre = "${var.workspace_tags_costcentre[terraform.workspace]}"
}

# module "bastion" {
#   source                    = "./modules/bastion"
#   ami                       = "${var.bastion-amis[var.aws_region]}"
#   vpc_cidr                  = "${var.vpc_cidr}"
#   aws_region                = "${var.aws_region}"
#   bastion_public_key        = "${var.bastion_public_key}"
#   public_sn_id              = "${module.vpc.public_sn_id}"
#   private_subnet_cidr_1a    = "${var.private_subnet_cidr_1a}"
#   private_subnet_cidr_1b    = "${var.private_subnet_cidr_1b}"
#   vpc_id                    = "${module.vpc.vpc_id}"
#   workspace_tags_project    = "${var.workspace_tags_project[terraform.workspace]}"
#   workspace_tags_costcentre = "${var.workspace_tags_costcentre[terraform.workspace]}"
# }

# module "webserver_cluster" {
#   source             = "./modules/webserver_cluster"
#   vpc_id             = "${module.vpc.vpc_id}"
#   ami                = "${data.aws_ami.ubuntu.id}"
#   server_text        = "Hello, World"
#   aws_region         = "${var.aws_region}"
#   cluster_name       = "${var.cluster_name}"
#   instance_type      = "t2.micro"
#   min_size           = 2
#   max_size           = 10
#   enable_autoscaling = true
# }

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
}
