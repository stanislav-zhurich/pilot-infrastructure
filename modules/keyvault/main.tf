data "azurerm_user_assigned_identity" "ado_application" {
  name                = "ado_terraform_mi"
  resource_group_name =  var.infra_resource_group_name
}

resource "azurerm_key_vault" "key_vault" {
  name                        = var.key_vault_name
  location                    = var.location_name
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  enable_rbac_authorization = true
  tags = var.tags
}

resource "azurerm_role_assignment" "ado_key_vault_contributor_assignement" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_user_assigned_identity.ado_application.principal_id
}

resource "azurerm_role_assignment" "terraform_key_vault_contributor_assignement" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.current_user_id
}