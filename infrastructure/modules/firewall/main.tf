resource "hcloud_firewall" "api" {
  name = "${var.environment}-api-fw"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = [var.bastion_ip]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "8080"
    source_ips = [var.private_network_cidr]
  }
}

resource "hcloud_firewall" "db" {
  name = "${var.environment}-db-fw"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = [var.bastion_ip]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "5432"
    source_ips = [var.private_network_cidr]
  }
}
