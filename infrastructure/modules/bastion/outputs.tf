output "public_ip" {
  value = hcloud_server.bastion.ipv4_address
}