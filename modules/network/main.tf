resource "azurerm_resource_group" "resource_group" {
  name     = "${var.environment}_resource_group"
  location = var.location_name
  tags = merge(var.tags, {environment = var.environment})
}

resource "azurerm_dns_zone" "public_dns_zone" {
  name                = "${var.environment}.pilotstan.com"
  resource_group_name = azurerm_resource_group.resource_group.name
  tags = merge(var.tags, {environment = var.environment})
}

resource "azurerm_network_security_group" "aks_nsg" {
  name                = var.aks_nsg_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dynamic "security_rule" {
    for_each = var.security_rules
    content {
        name                       = security_rule.value.name
        priority                   = security_rule.value.priority
        direction                  = security_rule.value.direction
        access                     = security_rule.value.access
        protocol                   = security_rule.value.protocol
        source_port_range          = security_rule.value.source_port_range
        destination_port_range     = security_rule.value.destination_port_range
        source_address_prefix      = security_rule.value.source_address_prefix
        destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

 tags = merge(var.tags, {environment = var.environment})
}

resource "azurerm_virtual_network" "default_vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = var.address_space
  tags = merge(var.tags, {environment = var.environment})
}

resource "azurerm_subnet" "aks_subnet" {
  resource_group_name = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.default_vnet.name
  name           = var.subnet_aks_name
  address_prefixes = var.subnet_aks_prefixes
}

resource "azurerm_subnet_network_security_group_association" "aks_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.aks_subnet.id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}