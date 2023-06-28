variable "service_bus_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location_name" {
  type = string
}

variable "servicebus_user_topic_name" {
  type = string
  default = "user_topic"
}

variable "servicebys_user_topic_auth_rule" {
  type = string
  default = "user_topic_send_listen_auth_rule"
}