terraform {
  required_providers {
    upcloud = {
      source  = "UpCloudLtd/upcloud"
      version = "~>5.19.0"
    }
  }
}

provider "upcloud" {}