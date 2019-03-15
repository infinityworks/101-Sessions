resource "aws_subnet" "eu-west-1a-public" {
  vpc_id = "${aws_vpc.iw_training_terraform.id}"

  cidr_block        = "${var.public_subnet_cidr_1a}"
  availability_zone = "eu-west-1a"

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "Public Subnet",
      "Description", "Public Subnet - 1a",
      "Tier", "public",
    )
  )}"
}

resource "aws_subnet" "eu-west-1a-private" {
  vpc_id = "${aws_vpc.iw_training_terraform.id}"

  cidr_block        = "${var.private_subnet_cidr_1a}"
  availability_zone = "eu-west-1a"

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "Private Subnet",
      "Description", "Private Subnet - 1a",
      "Tier", "private",
    )
  )}"
}

resource "aws_subnet" "eu-west-1b-private" {
  vpc_id = "${aws_vpc.iw_training_terraform.id}"

  cidr_block        = "${var.private_subnet_cidr_1b}"
  availability_zone = "eu-west-1b"

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "Private Subnet",
      "Description", "Private Subnet - 1b",
      "Tier", "private",
    )
  )}"
}
