resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.cosmosdb_account_name
  location            = var.location_name
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"

  capabilities {
    name = "EnableServerless"
  }


  consistency_policy {
    consistency_level       = "Session"
  }

  geo_location {
    location          = var.location_name
    failover_priority = 0
  }
}