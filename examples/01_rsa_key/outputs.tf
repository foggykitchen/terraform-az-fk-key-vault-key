output "key_vault_id" {
  description = "Key Vault resource ID."
  value       = module.key_vault.key_vault_id
}

output "key_vault_name" {
  description = "Key Vault name."
  value       = module.key_vault.key_vault_name
}

output "key_id" {
  description = "Versioned Key Vault key ID."
  value       = module.key.id
}

output "key_versionless_id" {
  description = "Versionless Key Vault key ID."
  value       = module.key.versionless_id
}

output "key_resource_versionless_id" {
  description = "Versionless Azure resource ID of the Key Vault key."
  value       = module.key.resource_versionless_id
}
