resource "aws_route_table_association" "eu-west-1a-public" {
  subnet_id      = "${aws_subnet.eu-west-1a-public.id}"
  route_table_id = "${aws_route_table.eu-west-1a-public.id}"
}

resource "aws_route_table_association" "eu-west-1a-private" {
  subnet_id      = "${aws_subnet.eu-west-1a-private.id}"
  route_table_id = "${aws_route_table.eu-west-1a-private.id}"
}

resource "aws_route_table_association" "eu-west-1b-private" {
  subnet_id      = "${aws_subnet.eu-west-1b-private.id}"
  route_table_id = "${aws_route_table.eu-west-1b-private.id}"
}