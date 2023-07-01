data "azuread_client_config" "current" {}

module "network" {
  source = "../../modules/network"
  environment = var.environment
  vnet_name = var.vnet_name
  address_space = var.address_space
  location_name = var.location_name
  security_rules = var.security_rules
  aks_nsg_name = "${var.environment}_${var.aks_nsg_name}"
  subnet_aks_prefixes = var.subnet_aks_prefixes
  subnet_aks_name = "${var.environment}_aks_subnet"
  public_ip_name = "${var.environment}_public_ip"
  infra_resource_group_name = var.infra_resource_group_name
}

module "cosmosdb" {
  source = "../../modules/cosmosdb"
  cosmosdb_account_name = "${var.environment}-pilot-account"
  location_name = module.network.resource_group.location
  resource_group_name = module.network.resource_group.name
  environment = var.environment
}

module "key_vault" {
  source = "../../modules/keyvault"
  resource_group_name = module.network.resource_group.name
  location_name = module.network.resource_group.location
  tenant_id = data.azuread_client_config.current.tenant_id
  key_vault_name = "${var.environment}-pilot-kv"
  tags = {environment = var.environment}
  current_user_id = data.azuread_client_config.current.object_id
  infra_resource_group_name = var.infra_resource_group_name
}

module "kubernetes_cluster" {
  source = "../../modules/k8s"
  cluster_name = "${var.environment}_cluster"
  dns_prefix_name = "${var.environment}cluster"
  location_name = module.network.resource_group.location
  number_of_instances = 1
  pool_name = "${var.environment}pool"
  resource_group_name = module.network.resource_group.name
  vm_size = "standard_b2s"
  aks_user_identity_name = "${var.environment}_aks_user_identity"
  aks_user_admin_group_members = ["881efb1c-9e27-4b58-823a-230f51d9a8f4"]
  aks_user_admin_group_owners = ["881efb1c-9e27-4b58-823a-230f51d9a8f4"]
  aks_user_admin_group_name = "${var.environment}_aks_user_admin_group"
  aks_subnet_id = module.network.aks_subnet.id
  org_service_url = var.org_service_url
  personal_access_token = var.personal_access_token
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  ado_project_id = var.ado_project_id
  service_endpoint_name = "${var.environment}_aks_service_endpoint"
  public_ip =  module.network.public_ip
}

module "servicebus" {
  source = "../../modules/servicebus"
  location_name = module.network.resource_group.location
  resource_group_name = module.network.resource_group.name
  service_bus_name = "${var.environment}pilotappservicebus"
}