data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "myinstance" {
  ami = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "myinstance - 101 Training"
  }
}
