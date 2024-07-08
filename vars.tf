variable env {
  description = "The environment to deploy to. Must match terraform workspace"
  type        = string
}

variable server_hostname {
  description = "The hostname of the server"
  type        = string
}

variable server_timezone {
  description = "The timezone of the server"
  type        = string
  default     = "Europe/Helsinki"
}
variable server_domain_name {
  description = "The domain name of the server"
  type        = string
}

variable server_zone {
  description = "The zone of the server"
  type        = string
  default     = "fi-hel2"
}

variable server_plan {
  description = "Server CPU and memory configuration"
  type        = string
  default     = "DEV-1xCPU-1GB"
}

variable storage_uuid {
  description = "The UUID of the disk to attach to the server"
  type        = string
  # Ubuntu Server 24.04 LTS (Noble Numbat)': 01000000-0000-4000-8000-000030240200
  # Debian GNU/Linux 12 (Bookworm)': 01000000-0000-4000-8000-000020070100
  default     = "01000000-0000-4000-8000-000030240200"
}

# Public SSH keys to add to the server. Must match exactly with the ones saved at UpCloud.
variable public_ssh_key_path {
  description = "Names of public SSH keys to add to the server"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  sensitive   = true
}