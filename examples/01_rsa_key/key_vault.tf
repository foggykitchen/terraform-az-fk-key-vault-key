data "azurerm_client_config" "current" {}

module "key_vault" {
  source = "github.com/foggykitchen/terraform-az-fk-key-vault"

  key_vault_name                = "${var.name_prefix}-kv-${random_string.suffix.result}"
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  rbac_authorization_enabled    = true
  purge_protection_enabled      = true
  soft_delete_retention_days    = 90
  public_network_access_enabled = true
  tags                          = var.tags
}

module "current_user_crypto_officer" {
  source = "github.com/foggykitchen/terraform-az-fk-rbac"

  scope                = module.key_vault.key_vault_id
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Key Vault Crypto Officer"
}
