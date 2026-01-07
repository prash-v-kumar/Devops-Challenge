resource "hcloud_server" "bastion" {
  name          = "${var.environment}-bastion"
  image         = var.osimage
  server_type   = var.server_type
  location      = var.location
  ssh_keys      = [var.ssh_key_id]
  
  network {
    network_id = var.network_id
  }
  
  public_net {
    ipv4_enabled = var.enableIP4
    ipv6_enabled = var.enableIP6
  }
}

resource "hcloud_firewall" "bastion_fw" {
  name = "${var.environment}-bastion-fw"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = var.allowed_admin_ips
  }
}

resource "hcloud_firewall_attachment" "dev_bastion_fw_attach" {
  firewall_id = hcloud_firewall.bastion_fw.id

  server_ids = [hcloud_server.bastion.id]

  depends_on = [
    hcloud_firewall.bastion_fw,
    hcloud_server.bastion
  ]
   
}