variable "environment" {
  default = "development"
}

variable "location_name" {
  default = "West Europe"
}

variable "default_nsg_name" {
  default = "default_nsg"
}

variable "vnet_name" {
  default = "default_vnet"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_1_name" {
  default = "subnet_1"
}

variable "subnet_1_prefix" {
  default = "10.0.1.0/24"
}

variable "client_id" {
  
}

variable "client_secret" {
  
}

variable "tenant_id" {
  
}

variable "subscription_id" {
  
}

variable "security_rules" {
  default = [
    {
        name                       = "80_allow"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    },
     {
        name                       = "443_allow"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
]
}

