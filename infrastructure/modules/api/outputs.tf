output "server_map" {
  value = {
    for idx, s in hcloud_server.api :
    "api-${idx}" => s.id
  }
}

output "public_ips" {
  value = hcloud_server.api[*].ipv4_address
}

output "server_ids" {
  value = hcloud_server.api[*].id
}