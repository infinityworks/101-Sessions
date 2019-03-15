resource "aws_eip" "nat" {
  vpc = true
}