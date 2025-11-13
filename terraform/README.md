# Azure Recovery Services Vault Terraform Module

This module creates an Azure Recovery Services Vault with security hardening configurations for backup and disaster recovery operations.

## Features

- Azure Recovery Services Vault with configurable storage redundancy
- Cross-region restore capabilities for GeoRedundant storage
- Soft delete protection for backup data
- System-assigned managed identity for secure access
- Optional default VM backup policy with retention schedules
- Resource tagging support
- Multiple storage modes (GeoRedundant, LocallyRedundant, ZoneRedundant)

## Usage

```hcl
module "recovery_vault" {
  source = "./terraform"

  name                = "rsv-prod-001"
  location            = "eastus"
  resource_group_name = "rg-backup-prod"

  sku               = "Standard"
  storage_mode_type = "GeoRedundant"

  # Security hardening
  enable_cross_region_restore  = true
  soft_delete_retention_days   = 14
  create_default_backup_policy = true

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Purpose     = "Backup"
  }
}
```

## Examples

See the `examples/` directory for more usage scenarios:
- `examples/basic/` - Basic recovery services vault with default settings
- `examples/hardened/` - Fully hardened recovery services vault with all security features

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| azurerm | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 4.0.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_recovery_services_vault | resource |
| azurerm_backup_policy_vm | resource (optional) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the recovery services vault | `string` | n/a | yes |
| location | Azure region where the vault will be created | `string` | n/a | yes |
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| sku | SKU for the vault (Standard or RS0) | `string` | `"Standard"` | no |
| storage_mode_type | Storage redundancy type | `string` | `"GeoRedundant"` | no |
| enable_cross_region_restore | Enable cross-region restore (GeoRedundant only) | `bool` | `true` | no |
| soft_delete_retention_days | Days to retain soft-deleted backups | `number` | `14` | no |
| create_default_backup_policy | Create default VM backup policy | `bool` | `true` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| recovery_vault_id | The ID of the recovery services vault |
| recovery_vault_name | The name of the recovery services vault |
| recovery_vault_identity | The managed identity of the vault |
| storage_mode_type | The storage mode type configured |
| soft_delete_enabled | Whether soft delete is enabled |
| default_backup_policy_id | The ID of the default backup policy (if created) |

## Security Hardening

This module implements several security best practices:

1. **Soft Delete**: Protects against accidental or malicious deletion of backup data
2. **Geo-Redundancy**: Ensures backup availability across regions with GeoRedundant storage
3. **Managed Identity**: Uses system-assigned identity for secure access to Azure resources
4. **Cross-Region Restore**: Enables disaster recovery from secondary region (GeoRedundant only)
5. **Default Backup Policy**: Optional VM backup policy with daily, weekly, monthly, and yearly retention
6. **Configurable Storage**: Support for LocallyRedundant, ZoneRedundant, and GeoRedundant storage modes

## Testing

Run tests using Terraform test:

```bash
terraform test
```

## License

See LICENSE file in the repository root.
