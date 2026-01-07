# API server IDs
output "api_servers" {
  value = module.api.public_ips
  description = "List of API server IPs"
}

# DB server IP
output "db_server" {
  value = module.database.public_ip
  description = "Database server IP"
}

# DB server IP
output "bastion_server" {
  value = module.bastion.public_ip
  description = "Bastion server IP"
}
