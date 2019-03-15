output "vpc_id" {
  value = "${aws_vpc.iw_training_terraform.id}"
}

output "sg_private_id" {
  value = "${aws_security_group.private.id}"
}

output "private_sn_1a_id" {
  value = "${aws_subnet.eu-west-1a-private.id}"
}

output "private_sn_1b_id" {
  value = "${aws_subnet.eu-west-1b-private.id}"
}

output "public_sn_id" {
  value = "${aws_subnet.eu-west-1a-public.id}"
}

output "sg_nat_id" {
  value = "${aws_security_group.nat.id}"
}

output "nat_gw_id" {
  value = "${aws_nat_gateway.gw.id}"
}
