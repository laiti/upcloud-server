data "local_file" "terraform_workspace_check" {
  count    = var.env == terraform.workspace ? 0 : 1
  filename = "Terraform workspace does not match the environment name. Please switch to the correct workspace."
}