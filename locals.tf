locals {
    server_hostname            = upcloud_server.server.hostname
    server_public_ipv4_address = upcloud_server.server.network_interface[0].ip_address
}