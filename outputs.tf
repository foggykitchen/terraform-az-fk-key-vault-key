output "id" {
  description = "The versioned Key Vault key ID."
  value       = azurerm_key_vault_key.this.id
}

output "name" {
  description = "The Key Vault key name."
  value       = azurerm_key_vault_key.this.name
}

output "version" {
  description = "The Key Vault key version."
  value       = azurerm_key_vault_key.this.version
}

output "versionless_id" {
  description = "The versionless Key Vault key ID."
  value       = azurerm_key_vault_key.this.versionless_id
}

output "resource_id" {
  description = "The versioned Azure resource ID of the Key Vault key."
  value       = azurerm_key_vault_key.this.resource_id
}

output "resource_versionless_id" {
  description = "The versionless Azure resource ID of the Key Vault key."
  value       = azurerm_key_vault_key.this.resource_versionless_id
}
