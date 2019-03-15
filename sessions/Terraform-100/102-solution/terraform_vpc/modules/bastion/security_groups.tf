resource "aws_security_group" "bastion" {
  name        = "sg_bastion"
  description = "Allow incoming SSH connections."

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "${var.private_subnet_cidr_1a}",
      "${var.private_subnet_cidr_1b}",
    ]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "public-bastion-sg",
      "Description", "The Bastion server to access the private servers",
    )
  )}"
}
