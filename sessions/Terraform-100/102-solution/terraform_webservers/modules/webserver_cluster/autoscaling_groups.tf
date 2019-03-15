resource "aws_autoscaling_group" "example" {
  name                 = "${var.cluster_name}-${aws_launch_configuration.example.name}"
  launch_configuration = "${aws_launch_configuration.example.id}"

  vpc_zone_identifier = ["${data.aws_subnet_ids.private.ids}"]
  load_balancers      = ["${aws_elb.example.name}"]
  health_check_type   = "ELB"

  min_size         = "${var.min_size}"
  max_size         = "${var.max_size}"
  min_elb_capacity = "${var.min_size}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}"
    propagate_at_launch = true
  }
}
