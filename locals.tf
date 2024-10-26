locals {
    server_hostname            = compact(concat(upcloud_server.server[*].hostname, list("")))
    server_public_ipv4_address = upcloud_server.server[*].network_interface[0].type == "public" ? compact(concat(upcloud_server.server[*].network_interface[0].ip_address, list(""))) : list("")
}