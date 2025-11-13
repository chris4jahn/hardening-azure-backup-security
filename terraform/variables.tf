# Input variables for Azure Recovery Services Vault module
# Variables are listed in alphabetical order

variable "create_default_backup_policy" {
  description = "Create a default VM backup policy with the vault"
  type        = bool
  default     = true
}

variable "enable_cross_region_restore" {
  description = "Enable cross-region restore capability for disaster recovery (only available with GeoRedundant storage)"
  type        = bool
  default     = true
}

variable "location" {
  description = "Azure region where the recovery services vault will be created"
  type        = string
  default     = "swedencentral"
}

variable "name" {
  description = "Name of the recovery services vault. Must be unique within the resource group"
  type        = string
  default     = "bofh-rs-vault111125"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{2,50}$", var.name))
    error_message = "Recovery Services Vault name must be 2-50 characters long and contain only letters, numbers, and hyphens."
  }
}

variable "sku" {
  description = "SKU for the Recovery Services Vault. Valid values: Standard, RS0 (Azure VMware Solution only)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "RS0"], var.sku)
    error_message = "SKU must be either Standard or RS0."
  }
}

variable "storage_mode_type" {
  description = "Storage mode type for the vault. Valid values: GeoRedundant, LocallyRedundant, ZoneRedundant"
  type        = string
  default     = "GeoRedundant"

  validation {
    condition     = contains(["GeoRedundant", "LocallyRedundant", "ZoneRedundant"], var.storage_mode_type)
    error_message = "Storage mode must be one of: GeoRedundant, LocallyRedundant, ZoneRedundant."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group where the recovery services vault will be created"
  type        = string
  default     = "bofh-backupvault01"
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft-deleted backups (0 to disable soft delete)"
  type        = number
  default     = 14

  validation {
    condition     = var.soft_delete_retention_days >= 0
    error_message = "Soft delete retention must be 0 or greater."
  }
}

variable "tags" {
  description = "Tags to apply to the recovery services vault resource"
  type        = map(string)
  default     = {}
}
