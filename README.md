# terraform-az-fk-key-vault-key

This repository contains a reusable Terraform / OpenTofu module and progressive examples for creating Azure Key Vault keys in the FoggyKitchen catalog.

It is part of the [FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/) and is designed to compose cleanly with reusable Azure infrastructure modules such as `terraform-az-fk-key-vault`, `terraform-az-fk-rbac`, `terraform-az-fk-managed-identity`, and database modules that consume customer-managed keys.

Support expectations are documented in [SUPPORT.md](SUPPORT.md).

---

## Purpose

The goal of this module is to provide a small, composable reference implementation for Azure Key Vault keys:

- Focused on `azurerm_key_vault_key`
- Suitable for customer-managed key scenarios such as PostgreSQL Flexible Server encryption
- Defaults to an RSA 4096-bit key with encrypt/decrypt, sign/verify, and wrap/unwrap operations
- Supports optional EC keys and optional rotation policy

This module does not create a Key Vault and does not assign RBAC roles. Use `terraform-az-fk-key-vault` for the vault and `terraform-az-fk-rbac` for authorization.

The examples are intentionally cost-conscious labs. They use the standard Key Vault SKU and software-backed RSA keys only. They do not use Premium Key Vault, Managed HSM, `RSA-HSM`, or `EC-HSM`.

---

## What the module does

The module creates:

- One Azure Key Vault key
- Optional key activation and expiration dates
- Optional key rotation policy

The module intentionally does not create:

- Azure Key Vaults
- Resource groups
- RBAC role assignments
- Access policies
- Managed identities
- Secrets or certificates

Each of those concerns belongs in its own dedicated module or workflow layer.

---

## Provider Notes

The module contract follows the AzureRM provider resource schema for `azurerm_key_vault_key`.

When the target Key Vault uses Azure RBAC, the principal running Terraform / OpenTofu must have enough Key Vault data-plane permissions to create keys, such as `Key Vault Crypto Officer`. Workloads that use the key, such as PostgreSQL Flexible Server with customer-managed key encryption, need their own role assignments composed outside this module.

---

## Repository Structure

```bash
terraform-az-fk-key-vault-key/
├── examples/
│   ├── 01_rsa_key/
│   └── README.md
├── main.tf
├── inputs.tf
├── outputs.tf
├── versions.tf
├── SUPPORT.md
├── LICENSE
└── README.md
```

---

## Example Usage

```hcl
module "postgresql_cmk_key" {
  source = "git::https://github.com/foggykitchen/terraform-az-fk-key-vault-key.git?ref=v0.1.0"

  name         = "postgresql-cmk"
  key_vault_id = module.key_vault.key_vault_id

  tags = {
    project = "foggykitchen"
    env     = "dev"
  }
}
```

For PostgreSQL Flexible Server CMK encryption, pass `module.postgresql_cmk_key.versionless_id` into `customer_managed_key.key_vault_key_id`.

---

## Module Inputs

| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `name` | `string` | yes | Key Vault key name |
| `key_vault_id` | `string` | yes | Azure Key Vault resource ID |
| `key_type` | `string` | no | Key type: `EC`, `EC-HSM`, `RSA`, or `RSA-HSM` |
| `key_size` | `number` | no | RSA key size in bits: `2048`, `3072`, or `4096` |
| `curve` | `string` | no | EC curve: `P-256`, `P-256K`, `P-384`, or `P-521` |
| `key_opts` | `list(string)` | no | Permitted key operations |
| `not_before_date` | `string` | no | Optional not-before date in RFC3339 format |
| `expiration_date` | `string` | no | Optional expiration date in RFC3339 format |
| `rotation_policy` | `object` | no | Optional Key Vault key rotation policy |
| `tags` | `map(string)` | no | Tags applied to the Key Vault key |

### `rotation_policy` object schema

```hcl
rotation_policy = object({
  expire_after         = optional(string)
  notify_before_expiry = optional(string)
  automatic = optional(object({
    time_after_creation = optional(string)
    time_before_expiry  = optional(string)
  }))
})
```

---

## Module Outputs

| Name | Description |
|------|-------------|
| `id` | Versioned Key Vault key ID |
| `name` | Key Vault key name |
| `version` | Key Vault key version |
| `versionless_id` | Versionless Key Vault key ID |
| `resource_id` | Versioned Azure resource ID of the Key Vault key |
| `resource_versionless_id` | Versionless Azure resource ID of the Key Vault key |

---

## Examples

See [examples/README.md](examples/README.md) for the progressive lab sequence.

---

## Cleanup

```bash
tofu destroy
```

---

## License

Licensed under the Universal Permissive License (UPL), Version 1.0.
See [LICENSE](LICENSE) for details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
