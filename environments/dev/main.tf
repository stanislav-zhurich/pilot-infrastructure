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
}

module "kubernetes_cluster" {

  depends_on = [ module.network ]
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
}