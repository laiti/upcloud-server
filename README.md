# upcloud-server
Terraform scripts to provision simple virtual server to UpCloud

## Setting up

1. To use the UpCloud API, you must disable MFA first. Then, configure two environment variables:
`export UPCLOUD_USERNAME=yourusername`
`export UPCLOUD_PASSWORD=yoursecurpassword`

2. Choose workspace name and `workspace.tfvars.example` to `yourworkspace.tfvars`. Usually workspaces are named development and production or similar.

3. If you wish have statefile somewhere else than in repository (for example S3 or synchronized directory), copy `statefile.tf.example` to `statefile.tf` and edit.

4. Run `terraform init` to get provider files etc.

5. Create your workspace: `terraform workspace new yourworkspace`

## Provisioning

`terraform workspace select yourworkspace`

`terraform apply -var-file=yourworkspace.tfvars`