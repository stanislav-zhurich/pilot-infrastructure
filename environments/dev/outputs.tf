output "aks_ip_address" {
  value = module.network.public_ip
  description = "IP address of AKS"
}

output "dns_record" {
  value = module.network.dns_record
  description = "DNS Record"
}