resource "hcloud_server" "api" {
  count       = var.instance_count
  name        = "${var.environment}-api-${count.index}"
  image       = var.osimage
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [var.ssh_key_id]

  network {
    network_id = var.network_id
  }

  firewall_ids = [var.firewall_id]

  public_net {
    ipv4_enabled = var.enableIP4
    ipv6_enabled = var.enableIP6
  }
}