output "id" {
  value = hcloud_server.db.id
}

output "public_ip" {
  value = hcloud_server.db.ipv4_address
}
