resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                = var.service_bus_name
  location            = var.location_name
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_servicebus_topic" "user_servicebus_topic" {
  name         = var.servicebus_user_topic_name
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id
  enable_partitioning = true
}

resource "azurerm_servicebus_topic_authorization_rule" "user_servicbus_topic_auth_rule" {
  name     = var.servicebys_user_topic_auth_rule
  topic_id = azurerm_servicebus_topic.user_servicebus_topic.id
  listen   = true
  send     = true
  manage   = true
}