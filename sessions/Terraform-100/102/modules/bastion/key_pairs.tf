resource "aws_key_pair" "bastion" {
  key_name   = "iw-101-key"
  public_key = "${var.bastion_public_key}"
}
