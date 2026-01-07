resource "hcloud_load_balancer" "lb" {
  name               = "${var.environment}-lb"
  load_balancer_type = "lb11"
  location           = var.location
}

resource "hcloud_load_balancer_service" "http" {
  load_balancer_id = hcloud_load_balancer.lb.id
  protocol         = "http"
  listen_port      = 80
  destination_port = 8080

  health_check {
    protocol = "http"
    port     = 8080
    interval = 15
    timeout  = 10
    retries  = 3

    http {
      path         = "/health"
      status_codes = ["200"]
    }
  }
}

resource "hcloud_load_balancer_network" "lb_net" {
  load_balancer_id = hcloud_load_balancer.lb.id
  network_id       = var.network_id
}

resource "hcloud_load_balancer_target" "api" {
  for_each         = var.api_servers
  load_balancer_id = hcloud_load_balancer.lb.id
  type             = "server"
  server_id        = each.value
  use_private_ip   = true

  depends_on = [
    hcloud_load_balancer.lb,
    hcloud_load_balancer_network.lb_net
  ]
}
