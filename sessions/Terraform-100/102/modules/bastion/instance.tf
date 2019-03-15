resource "aws_instance" "bastion" {
  ami                         = "${var.ami}"
  availability_zone           = "${var.aws_region}a"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.bastion.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  subnet_id                   = "${var.public_sn_id}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "public-bastion-ec2",
      "Description", "Bastion Instance",
    )
  )}"
}
