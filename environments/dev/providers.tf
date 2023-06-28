provider "azurerm" {
  features {

  }
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

provider "azuread" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "azuredevops" {
  personal_access_token = var.personal_access_token
  org_service_url = var.org_service_url
}
