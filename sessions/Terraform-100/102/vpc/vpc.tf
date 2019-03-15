resource "aws_vpc" "iw_training_terraform" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "terraform-iw-100",
      "Description", "Infinity Works 100 Training VPC",
    )
  )}"
}
