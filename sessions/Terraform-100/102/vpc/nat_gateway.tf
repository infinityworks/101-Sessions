resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.eu-west-1a-public.id}"

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "NAT Gateway",
      "Description", "NAT Gateway",
    )
  )}"

  depends_on = ["aws_eip.nat"]
}