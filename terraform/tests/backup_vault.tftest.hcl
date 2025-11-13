# Terraform tests for Azure Backup Vault module
# Tests validate inputs, resource creation, and security configurations

# Test: Default configuration
run "default_configuration" {
  command = plan

  variables {
    name                = "bv-test-default"
    location            = "eastus"
    resource_group_name = "rg-test"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.redundancy == "GeoRedundant"
    error_message = "Default redundancy should be GeoRedundant"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.cross_region_restore_enabled == true
    error_message = "Cross-region restore should be enabled by default"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.soft_delete == "On"
    error_message = "Soft delete should be enabled by default"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.retention_duration_in_days == 14
    error_message = "Default soft delete retention should be 14 days"
  }
}

# Test: Cross-region restore enabled
run "cross_region_restore_enabled" {
  command = plan

  variables {
    name                        = "bv-test-crr"
    location                    = "eastus"
    resource_group_name         = "rg-test"
    enable_cross_region_restore = true
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.cross_region_restore_enabled == true
    error_message = "Cross-region restore should be enabled when specified"
  }
}

# Test: Cross-region restore disabled
run "cross_region_restore_disabled" {
  command = plan

  variables {
    name                        = "bv-test-no-crr"
    location                    = "eastus"
    resource_group_name         = "rg-test"
    enable_cross_region_restore = false
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.cross_region_restore_enabled == false
    error_message = "Cross-region restore should be disabled when specified"
  }
}

# Test: Custom redundancy configuration
run "zone_redundant_storage" {
  command = plan

  variables {
    name                = "bv-test-zrs"
    location            = "eastus"
    resource_group_name = "rg-test"
    redundancy          = "ZoneRedundant"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.redundancy == "ZoneRedundant"
    error_message = "Redundancy should be ZoneRedundant when specified"
  }
}

# Test: Soft delete disabled
run "soft_delete_disabled" {
  command = plan

  variables {
    name                       = "bv-test-no-softdelete"
    location                   = "eastus"
    resource_group_name        = "rg-test"
    soft_delete_retention_days = 0
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.soft_delete == "Off"
    error_message = "Soft delete should be Off when retention is 0"
  }
}

# Test: Extended soft delete retention
run "extended_soft_delete" {
  command = plan

  variables {
    name                       = "bv-test-extended-softdelete"
    location                   = "eastus"
    resource_group_name        = "rg-test"
    soft_delete_retention_days = 90
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.retention_duration_in_days == 90
    error_message = "Soft delete retention should be 90 days when specified"
  }
}

# Test: Managed identity
run "managed_identity_configured" {
  command = plan

  variables {
    name                = "bv-test-identity"
    location            = "eastus"
    resource_group_name = "rg-test"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.identity[0].type == "SystemAssigned"
    error_message = "Managed identity should be SystemAssigned"
  }
}

# Test: Tags applied
run "tags_applied" {
  command = plan

  variables {
    name                = "bv-test-tags"
    location            = "eastus"
    resource_group_name = "rg-test"
    tags = {
      Environment = "Test"
      Purpose     = "Validation"
    }
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.tags["Environment"] == "Test"
    error_message = "Environment tag should be applied"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.tags["Purpose"] == "Validation"
    error_message = "Purpose tag should be applied"
  }
}

# Test: Hardened configuration (all security features)
run "hardened_configuration" {
  command = plan

  variables {
    name                        = "bv-test-hardened"
    location                    = "eastus"
    resource_group_name         = "rg-test"
    redundancy                  = "GeoRedundant"
    enable_cross_region_restore = true
    soft_delete_retention_days  = 90
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.redundancy == "GeoRedundant"
    error_message = "Redundancy should be GeoRedundant"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.cross_region_restore_enabled == true
    error_message = "Cross-region restore should be enabled"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.soft_delete == "On"
    error_message = "Soft delete should be enabled"
  }

  assert {
    condition     = azurerm_data_protection_backup_vault.this.retention_duration_in_days == 90
    error_message = "Extended soft delete retention should be 90 days"
  }
}
