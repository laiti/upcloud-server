resource "upcloud_server" "server" {
  firewall = var.firewall
  hostname = "${var.server_hostname}.${var.server_domain_name}"
  title    = "${var.server_hostname}"
  timezone = var.server_timezone
  zone     = var.server_zone
  plan     = var.server_plan
  metadata = true

  template {
    # Storage size in GB
    size    = 10
    storage = var.storage_uuid
    title   = "${var.server_hostname} root disk"
    encrypt = true
  }

  # Network interfaces
  dynamic "network_interface" {
    for_each = var.public_network
    content {
      type              = "public"
      ip_address_family = network_interface.value
    }
  }

  # No need for utility NW for a single server
  dynamic "network_interface" {
    for_each = var.utility_network
    content {
      type              = "utility"
      ip_address_family = network_interface.value
    }
  }

  connection {
    # Server public IP addr
    host        = self.network_interface[0].ip_address
    type        = "ssh"
    user        = "root"
    # Use this only with keys without passphrase that are not added to SSH agent
    #private_key =
  }

  # This causes "The attribute ssh_keys has an invalid value.", type="SSH_KEYS_INVALID"
  login {
    user            = "root"
    keys            = [file(var.public_ssh_key_path)]
    create_password = false
  }

  provisioner "remote-exec" {
    inline = var.init_command
  }
}


# UpCloud Terraform provider does not support setting PTR record for a host
# but their API does so we set it via this script.

resource "null_resource" "set_ipv4_ptr_record" {
  provisioner "local-exec" {
    command = "tools/set-ptr-record.sh ${local.server_public_ipv4_address} ${local.server_hostname}"
  }
}

resource "null_resource" "set_ipv6_ptr_record" {
  provisioner "local-exec" {
    command = "tools/set-ptr-record.sh ${local.server_public_ipv6_address} ${local.server_hostname}"
  }
}