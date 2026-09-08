variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "location" {
  type        = string
  description = "Azure region."
  default     = "westeurope"
}

variable "name_prefix" {
  type        = string
  description = "Name prefix for example resources."
  default     = "fk-kvk01"
}

variable "key_name" {
  type        = string
  description = "Key Vault key name."
  default     = "cmk-rsa"
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
  default = {
    project     = "foggykitchen"
    environment = "dev"
    managed_by  = "opentofu"
  }
}
