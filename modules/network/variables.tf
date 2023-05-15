variable "environment" {
  type = string
}

variable "location_name" {
  type = string
}

variable "tags" {
  type = map
  default = {owner = "stan"}
}

variable "aks_nsg_name" {
  type = string
}

variable "security_rules" {
  type = list
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet_aks_prefixes" {
  type = list(string)
}

variable "subnet_aks_name" {
  type = string
}