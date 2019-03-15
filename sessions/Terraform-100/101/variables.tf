variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "eu-west-1"
}

variable "iam_role" {
  description = "The AWS STS assume role used to execute Terraform"
  default     = ""
}
