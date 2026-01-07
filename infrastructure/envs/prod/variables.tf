variable "hcloud_token" {
  sensitive = true
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "ssh_public_key" {
  type = string
}

variable "location" {
  type    = string
  default = "nbg1"
}

variable "api_instance_count" {
  type = number
}

variable "allowed_admin_ips" {
  type = list(string)
}

variable "private_network_cidr" {
  type = string
}

variable "server_type" {
  type    = string
  default = "cx23"
}

variable "api_server_type" {
  type    = string
  default = "cx23"
}

variable "db_server_type" {
  type    = string
  default = "cx23"
}

variable "osimage" {
  type    = string
  default = "ubuntu-22.04"
}

variable "enableIP4" {
  type = bool
}

variable "enableIP6" {
  type = bool
}

variable "vpc_name" {
  type = string
}

variable "vpc_ip_range" {
  type = string
}

variable "subnet_ip_range" {
  type = string
}

variable "network_type" {
  type = string
}

variable "network_zone" {
  type = string
}