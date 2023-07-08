data "azurerm_subscription" "current" {
}

resource "azuredevops_serviceendpoint_kubernetes" "aks_ado_serviceendpoint" {
  project_id            = var.ado_project_id
  service_endpoint_name = var.service_endpoint_name
  apiserver_url = "https://${azurerm_kubernetes_cluster.kubernetes_cluster.fqdn}"
  authorization_type    = "AzureSubscription"

  azure_subscription {
    subscription_id   = data.azurerm_subscription.current.subscription_id
    subscription_name = data.azurerm_subscription.current.display_name
    tenant_id         = data.azurerm_subscription.current.tenant_id
    resourcegroup_id  = var.resource_group_name
    namespace         = "default"
    cluster_name      = var.cluster_name
  }
}


resource "azurerm_user_assigned_identity" "aks_user_identity" {
  location            = var.location_name
  name                = var.aks_user_identity_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "aks_role_assignement" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_user_identity.principal_id
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
  private_cluster_enabled = false
  local_account_disabled = false
  oidc_issuer_enabled = true
  workload_identity_enabled = true



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
}


provider "helm" {
  kubernetes {
    host = azurerm_kubernetes_cluster.kubernetes_cluster.kube_admin_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.kubernetes_cluster.kube_admin_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.kubernetes_cluster.kube_admin_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.kubernetes_cluster.kube_admin_config.0.cluster_ca_certificate)
  }
}

resource "helm_release" "keda" {
  name = "keda"
  namespace = "keda"
  create_namespace = true
  repository = "https://kedacore.github.io/charts"
  chart = "keda"
}

resource "helm_release" "ingress_controller" {
  name = "ingress-nginx"
  namespace = "ingress-nginx"
  create_namespace = true
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  recreate_pods = true
  atomic = true

  set {
    name  = "controller.service.loadBalancerIP"
    value =var.public_ip
  }
  set {
    name  = "controller.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }
  set {
    name  = "controller.admissionWebhooks.patch.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal"
    value = false
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-ipv4"
    value = var.public_ip
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = var.resource_group_name
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "healthz"
  }

  set {
    name  = "defaultBackend.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }
}


