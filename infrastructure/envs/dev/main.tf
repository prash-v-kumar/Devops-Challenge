resource "hcloud_ssh_key" "default" {
  name       = "${var.environment}-key"
  public_key = file(var.ssh_public_key)
}

module "network" {
  source          = "../../modules/network"
  vpc_name        = var.vpc_name
  vpc_ip_range    = var.vpc_ip_range
  subnet_ip_range = var.subnet_ip_range
  network_type    = var.network_type
  network_zone    = var.network_zone
}

module "bastion" {
  source            = "../../modules/bastion"
  environment       = var.environment
  server_type       = var.server_type
  osimage           = var.osimage
  location          = var.location
  ssh_key_id        = hcloud_ssh_key.default.id
  network_id        = module.network.network_id
  allowed_admin_ips = var.allowed_admin_ips
  enableIP4         = var.enableIP4
  enableIP6         = var.enableIP6
}

module "api" {
  source         = "../../modules/api"
  environment    = var.environment
  instance_count = var.api_instance_count
  server_type    = var.api_server_type
  osimage        = var.osimage
  location       = var.location
  ssh_key_id     = hcloud_ssh_key.default.id
  network_id     = module.network.network_id
  firewall_id    = module.firewall.api
  enableIP4      = var.enableIP4
  enableIP6      = var.enableIP6
}

module "database" {
  source      = "../../modules/database"
  environment = var.environment
  server_type = var.db_server_type
  osimage     = var.osimage
  location    = var.location
  ssh_key_id  = hcloud_ssh_key.default.id
  network_id  = module.network.network_id
  firewall_id = module.firewall.db
  enableIP4   = var.enableIP4
  enableIP6   = var.enableIP6
}



module "loadbalancer" {
  source      = "../../modules/loadbalancer"
  environment = var.environment
  location    = var.location
  api_servers = module.api.server_map
  network_id  = module.network.network_id
  depends_on = [
    module.api
  ]
}


module "firewall" {
  source               = "../../modules/firewall"
  environment          = var.environment
  bastion_ip           = module.bastion.public_ip
  private_network_cidr = var.private_network_cidr
}