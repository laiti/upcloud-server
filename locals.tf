locals {
    server_hostname             = upcloud_server.server.hostname
    server_public_ipv4_address  = upcloud_server.server.network_interface[0].ip_address
    server_public_ipv6_address  = upcloud_server.server.network_interface[1].ip_address
}