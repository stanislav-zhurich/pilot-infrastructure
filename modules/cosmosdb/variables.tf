variable "resource_group_name" {
  type = string
}

variable "location_name" {
  type = string
}

variable "cosmosdb_account_name" {
  type = string
}

variable "tags" {
  type = map
  default = {owner = "stan", type="cosmosdb_account"}
}

variable "environment" {
  type = string
}