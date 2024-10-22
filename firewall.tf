resource "upcloud_firewall_rules" "server_firewall" {
    server_id = upcloud_server.server.id

    firewall_rule {
        count                  = length(var.ssh_allow)
        action                 = "accept"
        comment                = "Allow SSH from this network"
        destination_port_end   = var.ssh_port
        destination_port_start = var.ssh_port
        direction              = "in"
        family                 = "IPv4"
        protocol               = "tcp"
        source_address_start   = var.ssh_allow[count.index][0]
        source_address_end     = var.ssh_allow[count.index][1]
    }
}