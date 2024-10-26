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

    // Create firewall rules for DNS entries in upcloud_dns. TF does not support nested for_each statements so
    // we create TCP and UDP rules separately
    dynamic "firewall_rule" {
        for_each = var.upcloud_dns
        content {
            action                 = "accept"
            direction              = "in"
            comment                = "Allow DNS from UpCloud DNS servers (UDP)"
            destination_port_start = 53
            destination_port_end   = 53
            // set family to IPv6 if it contains colon, otherwise use IPv4
            family                 = length(regexall(":", firewall_rule.value)) > 0 ? "IPv6" : "IPv4"
            protocol               = "udp"
            source_address_start   = firewall_rule.value
            source_address_end     = firewall_rule.value
        }
    }

    dynamic "firewall_rule" {
        for_each = var.upcloud_dns
        content {
            action                 = "accept"
            direction              = "in"
            comment                = "Allow DNS from UpCloud DNS servers (TCP)"
            destination_port_start = 53
            destination_port_end   = 53
            // set family to IPv6 if it contains colon, otherwise use IPv4
            family                 = length(regexall(":", firewall_rule.value)) > 0 ? "IPv6" : "IPv4"
            protocol               = "tcp"
            source_address_start   = firewall_rule.value
            source_address_end     = firewall_rule.value
        }
    }

    // Default rule: drop everything else
    firewall_rule {
        action    = "drop"
        direction = "in"
    }
}