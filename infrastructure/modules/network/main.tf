resource "hcloud_network" "this" {
  name     = var.vpc_name
  ip_range = var.vpc_ip_range
}

resource "hcloud_network_subnet" "subnet" {
  network_id = hcloud_network.this.id
  type       = var.network_type
  network_zone = var.network_zone
  ip_range   = var.subnet_ip_range
}
