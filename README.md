# upcloud-server
Terraform scripts to provision simple virtual server to UpCloud

## Setting up

1. To use the UpCloud API, you must disable MFA first. Then, configure two environment variables:
`export UPCLOUD_USERNAME=yourusername`
`export UPCLOUD_PASSWORD=yoursecurpassword`

2. Choose workspace name and `workspace.tfvars.example` to `yourworkspace.tfvars`. Usually workspaces are named development and production or similar. You can also go with default workspace.

3. Optional: If you wish have statefile somewhere else than in repository (for example S3 or some synchronized cloud directory), copy `statefile.tf.example` to `statefile.tf` and edit.

4. Run `terraform init` to get provider files etc.

5. Create your workspace: `terraform workspace new yourworkspace`

## Provisioning

`terraform workspace select yourworkspace`

`terraform apply -var-file=yourworkspace.tfvars`

## Tools

Tools directory contains simple tools for interacting with UpCloud API.

### `getuuids.py`

UpCloud does not provide any handy lists with disk image UUIDs (or at least I've found none) so this script fetches them from the API. Requires the same environment variables as the 'Setting up' part above. The `vars.tf` contains only couple of the image UUIDs and they deprecate over time anyway.

To run:

`pip install upcloud-api`

`python getuuids.py`

### `set-ptr-record.sh`

A script to set PTR record via UpCloud API. UpCloud Terraform provider does not support PTR records so we call this script from Terraform using null provider.
