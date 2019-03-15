resource "aws_elb" "example" {
  name            = "${var.cluster_name}"
  subnets         = ["${data.aws_subnet_ids.private.ids}"]
  security_groups = ["${aws_security_group.elb.id}"]
  internal        = true

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }

  lifecycle {
    create_before_destroy = true
  }
}
