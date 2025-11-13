# Azure Recovery Services Vault Module
# Provider: azurerm >= 4.0.0
# Resource: azurerm_recovery_services_vault
# Purpose: Creates a hardened Azure Recovery Services Vault for secure backup operations

resource "azurerm_recovery_services_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  # Storage mode configuration
  storage_mode_type = var.storage_mode_type

  # Enable cross-region restore for GeoRedundant storage
  cross_region_restore_enabled = var.enable_cross_region_restore && var.storage_mode_type == "GeoRedundant"

  # Soft delete configuration
  soft_delete_enabled = var.soft_delete_retention_days > 0

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Enhanced soft delete settings
resource "azurerm_backup_policy_vm" "default" {
  count = var.create_default_backup_policy ? 1 : 0

  name                = "${var.name}-default-policy"
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.this.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 30
  }

  retention_weekly {
    count    = 12
    weekdays = ["Sunday"]
  }

  retention_monthly {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }

  retention_yearly {
    count    = 5
    weekdays = ["Sunday"]
    weeks    = ["First"]
    months   = ["January"]
  }
}
