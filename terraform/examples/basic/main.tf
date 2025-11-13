# Basic Azure Backup Vault Example
# Provider: azurerm >= 4.0.0

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group for the example
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

# Create the backup vault using the module
module "backup_vault" {
  source = "../../"

  name                = var.backup_vault_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # Use default values for security settings
  # - datastore_type: VaultStore
  # - redundancy: GeoRedundant
  # - enable_cross_region_restore: true
  # - enable_immutability: true
  # - soft_delete_retention_days: 14

  tags = var.tags

  depends_on = [azurerm_resource_group.example]
}
