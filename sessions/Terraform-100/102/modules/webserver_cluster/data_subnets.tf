data "aws_subnet_ids" "private" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Tier = "private"
  }
}
