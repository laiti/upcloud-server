terraform {
  required_providers {
    upcloud = {
      source  = "UpCloudLtd/upcloud"
      version = "~>5.13.2"
    }
  }
}

provider "upcloud" {}