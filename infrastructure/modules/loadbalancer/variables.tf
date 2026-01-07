variable "environment" {
  type        = string
}

variable "location" {
  description = "location where the server will be provisioned"
  type        = string
}

variable "api_servers" {
  description = "Map of API servers (static keys)"
  type        = map(string)
}

variable "network_id" {
  description = "ID of the Hetzner private network to attach the server to"
  type        = string
}
