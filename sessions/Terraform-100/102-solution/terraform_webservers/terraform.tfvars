variable "workspace_iam_roles" {
  default = {
    development = "arn:aws:iam::455073406672:role/OrganizationAccountAccessRole"
    production  = ""
  }
}
