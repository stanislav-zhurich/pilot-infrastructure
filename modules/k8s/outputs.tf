output "kubernetes_cluster" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster
  description = "Kubernetes Cluster"
}

output "kubernetes_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.fqdn
  description = "fqdn"
}

output "kubernetes_cluster_dns_prefix" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.dns_prefix
  description = "dns_prefix"
}

output "kubernetes_cluster_config" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_admin_config
  description = "config"
}