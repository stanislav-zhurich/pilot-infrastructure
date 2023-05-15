output "resource_group" {
  value = azurerm_resource_group.resource_group
  description = "default resource group"
}

output "public_dns_zone" {
  value = azurerm_dns_zone.public_dns_zone
  description = "public dns zone"
}

output "aks_nsg" {
  value = azurerm_network_security_group.aks_nsg
  description = "network security group"
}

output "vnet" {
  value = azurerm_virtual_network.default_vnet
  description = "default virtual network"
}

output "aks_subnet" {
  value = azurerm_subnet.aks_subnet
  description = "AKS network subnet"
}

output "environment" {
  value = var.environment
}