module "key" {
  source = "../../"

  name         = var.key_name
  key_vault_id = module.key_vault.key_vault_id
  tags         = var.tags

  depends_on = [
    module.current_user_crypto_officer
  ]
}
