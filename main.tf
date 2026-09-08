locals {
  rsa_key            = contains(["RSA", "RSA-HSM"], var.key_type)
  ec_key             = contains(["EC", "EC-HSM"], var.key_type)
  effective_key_size = local.rsa_key ? coalesce(var.key_size, 4096) : null
}

resource "azurerm_key_vault_key" "this" {
  name            = var.name
  key_vault_id    = var.key_vault_id
  key_type        = var.key_type
  key_size        = local.effective_key_size
  curve           = local.ec_key ? coalesce(var.curve, "P-256") : null
  key_opts        = var.key_opts
  not_before_date = var.not_before_date
  expiration_date = var.expiration_date
  tags            = var.tags

  dynamic "rotation_policy" {
    for_each = var.rotation_policy == null ? [] : [var.rotation_policy]

    content {
      expire_after         = rotation_policy.value.expire_after
      notify_before_expiry = rotation_policy.value.notify_before_expiry

      dynamic "automatic" {
        for_each = rotation_policy.value.automatic == null ? [] : [rotation_policy.value.automatic]

        content {
          time_after_creation = automatic.value.time_after_creation
          time_before_expiry  = automatic.value.time_before_expiry
        }
      }
    }
  }

  lifecycle {
    precondition {
      condition     = local.rsa_key || var.key_size == null
      error_message = "key_size can only be set for RSA and RSA-HSM keys."
    }

    precondition {
      condition     = local.ec_key || var.curve == null
      error_message = "curve can only be set for EC and EC-HSM keys."
    }
  }
}
