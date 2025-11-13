# Variables for hardened example

variable "backup_vault_name" {
  description = "Name of the backup vault"
  type        = string
  default     = "bv-prod-hardened-001"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-backup-prod"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Example     = "Hardened"
    Security    = "Maximum"
    Compliance  = "Required"
  }
}
