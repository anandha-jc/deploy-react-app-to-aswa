output "static_web_app_id" {
  description = "The ID of the Azure Static Web App"
  value       = azurerm_static_web_app.main.id
}

output "static_web_app_default_hostname" {
  description = "The default hostname of the Static Web App"
  value       = azurerm_static_web_app.main.default_host_name
}

output "static_web_app_api_key" {
  description = "The API key for deploying to the Static Web App"
  value       = azurerm_static_web_app.main.api_key
  sensitive   = true
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.main.name
}
