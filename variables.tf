# Terraform variables

variable "availability_zone" {
  type    = string
  default = "us-west-1a"
}

variable "vpc_cidr" {
  type    = string
  default = "172.31.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "demo-vpc"
}

variable "subnet_cidr" {
  type    = string
  default = "172.31.1.0/24"
}

variable "subnet_name" {
  type    = string
  default = "demo-subnet"
}

variable "rt_ipv4_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "rt_ipv6_cidr" {
  type    = string
  default = "::/0"
}

variable "rt_name" {
  type    = string
  default = "demo-route-table"
}

variable "secgrp_HTTPS_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "secgrp_HTTP_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "secgrp_SSH_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "secgrp_protocol" {
  type    = string
  default = "tcp"
}

variable "secgrp_name" {
  type    = string
  default = "demo-security-group"
}

variable "network_interface_ip" {
  type    = string
  default = "172.31.1.50"
}

variable "web_name" {
  type    = string
  default = "demo-web-server"
}
