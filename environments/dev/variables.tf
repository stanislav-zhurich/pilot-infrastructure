variable "environment" {
  default = "develop"
}

variable "location_name" {
  default = "West Europe"
}

variable "aks_nsg_name" {
  default = "aks_nsg"
}

variable "vnet_name" {
  default = "default_vnet"
}

variable "address_space" {
  default = ["10.1.0.0/16"]
}

variable "subnet_aks_prefixes" {
  default = ["10.1.0.0/22"]
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



variable "client_id" {
   type = string
}

variable "client_secret" {
   type = string
}

variable "tenant_id" {
   type = string
}

variable "subscription_id" {
   type = string
}

variable "ado_project_id" {
  type = string
  default = "8412a1d1-7144-4c3e-b6cd-02bbfb9f60ee"
}

variable "org_service_url" {
  type = string
  default = "https://dev.azure.com/stancorp/"
}

variable "personal_access_token" {
  type = string
}

