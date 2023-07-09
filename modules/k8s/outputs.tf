output "kubernetes_cluster" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster
  description = "Kubernetes Cluster"
}

output "aks_managed_identity" {
  value = azurerm_user_assigned_identity.aks_user_identity
  description = "Kubernetes Cluster Managed Identity"
}