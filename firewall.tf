resource "upcloud_firewall_rules" "server_firewall" {
    server_id = upcloud_server.server.id

    // Add SSH allow rules for each network in ssh_allow list
    dynamic "firewall_rule" {
        for_each = var.firewall_allow
        content {
            action                 = "accept"
            direction              = "in"
            comment                = "Allow ${firewall_rule.value.name}"
            destination_port_start = firewall_rule.value.port_start
            destination_port_end   = try(firewall_rule.value.port_end, firewall_rule.value.port_start)
            family                 = try(firewall_rule.value.family, null)
            protocol               = try(firewall_rule.value.protocol, null)
            source_address_start   = try(firewall_rule.value.start, null)
            source_address_end     = try(firewall_rule.value.end, firewall_rule.value.start, null)
        }
    }
}