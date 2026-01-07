output "db" {
  value = hcloud_firewall.db.id
}

output "api" {
  value = hcloud_firewall.api.id
}
