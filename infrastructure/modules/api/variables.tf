variable "environment" {
  type        = string
}

variable "instance_count" {
  type = number
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

variable "firewall_id" {
  description = "firewall id to be attach the server to"
  type        = number
}

variable "osimage" {
  description = "firewall id to be attach the server to"
  type        = string
}

variable "enableIP4"{
  type = bool
}

variable "enableIP6"{
  type = bool 
}