variable env {
  description = "The environment to deploy to. Must match terraform workspace"
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
  default     = "DEV-1xCPU-1GB-10GB"
}

variable storage_uuid {
  description = "The UUID of the disk to attach to the server"
  type        = string
  # Ubuntu Server 24.04 LTS (Noble Numbat)': 01000000-0000-4000-8000-000030240200
  # Debian GNU/Linux 12 (Bookworm)': 01000000-0000-4000-8000-000020070100
  default     = "01000000-0000-4000-8000-000030240200"
}

variable server_hostname {
  description = "The hostname of the server"
  type        = string
}

variable server_domain_name {
  description = "The domain name of the server"
  type        = string
}

# We're running Linux so HW clock must be in UTC
variable server_timezone {
  description = "The timezone of the server"
  type        = string
  default     = "UTC"
}

# Network address families.  To disable nerwork, set to []. For both families, use ["IPv4", "IPv6"]
variable utility_network {
  description = "Select which network address families to enable in utility network."
  type        = list
  default     = ["IPv4"]
}

variable public_network {
  description = "Which network address families to enable in public network."
  type        = list
  default     = ["IPv4"]
}

# Public SSH keys to add to the server. Must match exactly with the ones saved at UpCloud.
variable public_ssh_key_path {
  description = "Names of public SSH keys to add to the server"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  sensitive   = true
}

variable init_command {
  description = "Commands to run on the server after creation"
  type        = list(string)
  default     = ["apt-get update", "apt-get -y upgrade"]
}

variable firewall {
  description = "For switching firewall on or off"
  type        = bool
  default     = false
}

variable firewall_allow {
  description = "Ports and addresses to allow traffic from"
  type        = list(any)
  default     = [
    {
      name       = "SSH"
      port_start = "22"
      family     = "IPv4"
      protocol   = "tcp"
    }
  ]
}

variable upcloud_dns {
  description = "List of UpCloud DNS server addresses for firewall"
  type        = list(string)
  default     = ["94.237.127.9", "94.237.40.9", "2a04:3540:53::1", "2a04:3544:53::1"]
}

variable upcloud_dhcp {
  description = "List of UpCloud DHCP server addresses for firewall"
  type        = list(string)
  default     = ["94.237.16.1"]
}