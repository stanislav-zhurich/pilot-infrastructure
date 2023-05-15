resource "azurerm_user_assigned_identity" "aks_user_identity" {
  location            = var.location_name
  name                = var.aks_user_identity_name
  resource_group_name = var.resource_group_name
}

resource "azuread_group" "aks_user_admin_group" {
  display_name     = var.aks_user_admin_group_name
  mail_enabled     = false
  security_enabled = true

  owners = var.aks_user_admin_group_owners
  members = var.aks_user_admin_group_members
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = var.cluster_name
  location            = var.location_name
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix_name
  private_cluster_enabled = true

  azure_active_directory_role_based_access_control {
    managed = true
    azure_rbac_enabled = true
    admin_group_object_ids = [  ]
  }
  network_profile {
    network_policy = "azure"
    network_plugin = "azure"
  }



  default_node_pool {
    name       = var.pool_name
    node_count = var.number_of_instances
    vm_size    = var.vm_size
    vnet_subnet_id = var.aks_subnet_id
  }

  identity {
    type = "UserAssigned"
    identity_ids = [ azurerm_user_assigned_identity.aks_user_identity.id ]
  }

  tags = {
    Environment = "Production"
  }
}
