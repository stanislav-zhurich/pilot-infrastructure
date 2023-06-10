resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = var.cosmosdb_account_name
  location            = var.location_name
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  tags = merge(var.tags, {environment = var.environment})

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

resource "azurerm_cosmosdb_sql_role_definition" "cosmosdb_data_contributor_role" {
  name                = "DataContributorRole"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
  type                = "CustomRole"
  assignable_scopes   = [azurerm_cosmosdb_account.cosmosdb_account.id]

  permissions {
    data_actions = ["Microsoft.DocumentDB/databaseAccounts/readMetadata",
        "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read", 
        "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery",
        "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed"]
  }
}