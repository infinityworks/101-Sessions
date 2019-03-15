resource "aws_security_group" "instance" {
  name   = "${var.cluster_name}-instance"
  vpc_id = "${var.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elb" {
  name   = "${var.cluster_name}-elb"
  vpc_id = "${var.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }
}
