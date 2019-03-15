provider "aws" {
  # UNCOMMNET IF USING ROLES IN AWS - IF THIS IS A NEW ACCOUNT YOU HAVE CREATED YOU WONT BE USING ROLES
  # assume_role = {
  #   role_arn = "${var.iam_role}"
  # }

  region = "${var.aws_region}"
}
