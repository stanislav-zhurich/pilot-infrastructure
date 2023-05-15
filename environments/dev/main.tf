module "network" {
  source = "../../modules/network"
  environment = var.environment
  vnet_name = var.vnet_name
  address_space = var.address_space
  location_name = var.location_name
  security_rules = var.security_rules
  default_nsg_name = var.default_nsg_name
  subnet_1_prefix = var.subnet_1_prefix
  subnet_1_name = var.subnet_1_name
}