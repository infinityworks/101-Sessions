resource "aws_route_table" "eu-west-1a-public" {
  vpc_id = "${aws_vpc.iw_training_terraform.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "Public Subnet Route table",
      "Description", "Public Subnet route table - 1a",
    )
  )}"
}

resource "aws_route_table" "eu-west-1a-private" {
  vpc_id = "${aws_vpc.iw_training_terraform.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "Private Subnet Route table",
      "Description", "Private Subnet Route table - 1a",
    )
  )}"
}

resource "aws_route_table" "eu-west-1b-private" {
  vpc_id = "${aws_vpc.iw_training_terraform.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "Private Subnet Route table",
      "Description", "Private Subnet Route table - 1b",
    )
  )}"
}