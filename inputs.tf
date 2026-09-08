variable "name" {
  type        = string
  description = "The name of the Key Vault key."

  validation {
    condition = (
      length(var.name) >= 1 &&
      length(var.name) <= 127 &&
      can(regex("^[A-Za-z0-9-]+$", var.name))
    )
    error_message = "The Key Vault key name must be 1-127 characters and contain only letters, numbers, and hyphens."
  }
}

variable "key_vault_id" {
  type        = string
  description = "The resource ID of the Azure Key Vault where the key will be created."
}

variable "key_type" {
  type        = string
  description = "The type of Key Vault key."
  default     = "RSA"

  validation {
    condition     = contains(["EC", "EC-HSM", "RSA", "RSA-HSM"], var.key_type)
    error_message = "key_type must be one of: EC, EC-HSM, RSA, RSA-HSM."
  }
}

variable "key_size" {
  type        = number
  description = "The size of the RSA key in bits. Used for RSA and RSA-HSM keys."
  default     = null

  validation {
    condition     = var.key_size == null || contains([2048, 3072, 4096], var.key_size)
    error_message = "key_size must be one of: 2048, 3072, 4096."
  }
}

variable "curve" {
  type        = string
  description = "The elliptic curve name. Used for EC and EC-HSM keys."
  default     = null

  validation {
    condition     = var.curve == null || contains(["P-256", "P-256K", "P-384", "P-521"], var.curve)
    error_message = "curve must be one of: P-256, P-256K, P-384, P-521."
  }
}

variable "key_opts" {
  type        = list(string)
  description = "The permitted JSON web key operations."
  default     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  validation {
    condition = alltrue([
      for key_opt in var.key_opts :
      contains(["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"], key_opt)
    ])
    error_message = "key_opts entries must be one of: decrypt, encrypt, sign, unwrapKey, verify, wrapKey."
  }
}

variable "not_before_date" {
  type        = string
  description = "Optional not-before date in RFC3339 format."
  default     = null
}

variable "expiration_date" {
  type        = string
  description = "Optional expiration date in RFC3339 format."
  default     = null
}

variable "rotation_policy" {
  type = object({
    expire_after         = optional(string)
    notify_before_expiry = optional(string)
    automatic = optional(object({
      time_after_creation = optional(string)
      time_before_expiry  = optional(string)
    }))
  })
  description = "Optional Key Vault key rotation policy."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Key Vault key."
  default     = {}
}
