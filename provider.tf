terraform {
  required_providers {
    upcloud = {
      source  = "UpCloudLtd/upcloud"
      version = "~>5.7.0"
    }
  }
}

provider "upcloud" {}