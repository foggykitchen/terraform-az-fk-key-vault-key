# Azure Key Vault Key with Terraform/OpenTofu - Training Examples

This directory contains progressive examples used with the **terraform-az-fk-key-vault-key** module.
The examples are designed as incremental building blocks for Azure Key Vault key and customer-managed key scenarios.

These examples are part of the [FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/) and are meant to be applied independently for learning and experimentation.

The labs are cost-conscious: they use standard Azure Key Vault and software-backed RSA keys. They do not deploy Premium Key Vault, Managed HSM, `RSA-HSM`, or `EC-HSM`.

---

## Example Overview

| Example | Title | Key Topics |
|:-------:|:------|:-----------|
| 01 | **RSA Key** | Key Vault, RBAC, RSA key, versionless key ID |

---

## How to Use

Each example directory contains:

- Terraform/OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the goal of the example
- A `terraform.tfvars.example` file with placeholder values

To run an example:

```bash
cd examples/01_rsa_key
cp terraform.tfvars.example terraform.tfvars
tofu init
tofu plan
tofu apply
```

The recommended learning path currently starts with:

```text
01
```

---

## Design Principles

- One example = one architectural goal
- The key module is isolated from Key Vault lifecycle and authorization concerns
- Key Vaults and RBAC are composed with dedicated FoggyKitchen modules
- Examples use standard Key Vault and software-backed keys to keep labs cost-conscious
- Examples avoid hidden dependencies between directories

---

## Related Resources

- [FoggyKitchen Azure Key Vault Key Module](../)
- [FoggyKitchen Azure Key Vault Module](https://github.com/foggykitchen/terraform-az-fk-key-vault)
- [FoggyKitchen Azure RBAC Module](https://github.com/foggykitchen/terraform-az-fk-rbac)
- [FoggyKitchen Azure Managed Identity Module](https://github.com/foggykitchen/terraform-az-fk-managed-identity)
- [FoggyKitchen Azure PostgreSQL Module](https://github.com/foggykitchen/terraform-az-fk-pg)

---

## Cleanup

Run cleanup from inside the example directory:

```bash
tofu destroy
```

---

## License

Licensed under the Universal Permissive License (UPL), Version 1.0.
See [LICENSE](../LICENSE) for details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
