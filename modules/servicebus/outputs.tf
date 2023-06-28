output "user_servicebus_topic" {
  value = azurerm_servicebus_topic.user_servicebus_topic
  description = "User Service Bus Topic"
}

output "user_servicbus_topic_auth_rule" {
  value = azurerm_servicebus_topic_authorization_rule.user_servicbus_topic_auth_rule
  description = "User Service Bus Auth Rule"
}