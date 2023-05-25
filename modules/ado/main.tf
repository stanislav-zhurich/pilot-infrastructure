resource "azuredevops_serviceendpoint_kubernetes" "aks_ado_serviceendpoint" {
  project_id            = "8412a1d1-7144-4c3e-b6cd-02bbfb9f60ee"
  service_endpoint_name = var.service_endpoint_name
  apiserver_url = "https://${azurerm_kubernetes_cluster.kubernetes_cluster.fqdn}"
  authorization_type    = "AzureSubscription"

  azure_subscription {
    subscription_id   = var.subscription_id
    subscription_name = "Pay-As-You-Go"
    tenant_id         = var.tenant_id
    resourcegroup_id  = var.resource_group_name
    namespace         = "default"
    cluster_name      = var.cluster_name
  }
}
