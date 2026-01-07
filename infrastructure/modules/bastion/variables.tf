variable "environment" {
  type        = string
}

variable "server_type" {
  type = string
}

variable "location" {
  description = "location where the server will be provisioned"
  type        = string
}

variable "ssh_key_id" {
  description = "ssh key to be attached to the server"
  type        = number
}

variable "network_id" {
  description = "ID of the Hetzner private network to attach the server to"
  type        = string
}

variable "osimage" {
  description = "firewall id to be attach the server to"
  type        = string
}

variable "allowed_admin_ips" {
  type    = list(string)
}

variable "enableIP4"{
  type = bool
}

variable "enableIP6"{
  type = bool 
}