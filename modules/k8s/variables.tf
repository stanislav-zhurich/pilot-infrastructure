variable "aks_user_identity_name" {
  type = string
}

variable "aks_subnet_id" {
    type = string
}

variable "aks_user_admin_group_owners" {
  type = list(string)
}

variable "aks_user_admin_group_members" {
  type = list(string)
}

variable "aks_user_admin_group_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location_name" {
  type = string
}

variable "dns_prefix_name" {
  type = string
}

variable "pool_name" {
  type = string
}

variable "number_of_instances" {
  type = number
}

variable "vm_size" {
  type = string
  default = "Standard DS2_v2"
}

variable "tenant_id" {
  type = string 
}

variable "subscription_id" {
  type = string
}

variable "org_service_url" {
  type = string
}

variable "personal_access_token" {
  type = string
}

variable "service_endpoint_name" {
  type = string
}

variable "ado_project_id" {
  type = string
}