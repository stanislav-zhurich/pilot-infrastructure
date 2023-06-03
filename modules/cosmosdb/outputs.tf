output "cosmosdb_account" {
    value = azurerm_cosmosdb_account.cosmosdb
}

output "cosmosdb_database" {
    value = azurerm_cosmosdb_sql_database.cosmosdb_database
}