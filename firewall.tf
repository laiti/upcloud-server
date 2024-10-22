resource "upcloud_firewall_rules" "server_firewall" {
    server_id = upcloud_server.server.id

    // Add SSH allow rules for each network in ssh_allow list
    dynamic "firewall_rule" {
        for_each = var.ssh_allow
        content {
            action                 = "accept"
            comment                = "Allow SSH from this network"
            destination_port_end   = var.ssh_port
            destination_port_start = var.ssh_port
            direction              = "in"
            family                 = "IPv4"
            protocol               = "tcp"
            source_address_start   = firewall_rule.value[0]
            source_address_end     = firewall_rule.value[1]
        }
    }
}