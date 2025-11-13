# Migration Guide: Backup Vault to Recovery Services Vault

## Overview

This module has been updated to use **Azure Recovery Services Vault** instead of **Azure Backup Vault** (Data Protection). This change provides broader compatibility with Azure backup scenarios and additional features.

## Key Differences

### Azure Backup Vault (Data Protection)
- Modern backup service for specific workloads
- Limited to: Azure Disks, Azure Blobs, Azure Database for PostgreSQL
- Uses `azurerm_data_protection_backup_vault` resource

### Azure Recovery Services Vault
- Traditional and widely-used backup service
- Supports: VMs, SQL, SAP HANA, File Shares, and more
- Uses `azurerm_recovery_services_vault` resource
- Includes built-in backup policies
- More mature and feature-rich

## Breaking Changes

### Resource Changes
| Old (Backup Vault) | New (Recovery Services Vault) |
|-------------------|-------------------------------|
| `azurerm_data_protection_backup_vault` | `azurerm_recovery_services_vault` |
| `datastore_type` variable | `sku` variable |
| `redundancy` variable | `storage_mode_type` variable |

### Variable Changes
| Old Variable | New Variable | Notes |
|-------------|--------------|-------|
| `datastore_type` | `sku` | Values: `Standard` or `RS0` |
| `redundancy` | `storage_mode_type` | Same values but different property |
| N/A | `create_default_backup_policy` | New: Creates default VM backup policy |

### Output Changes
| Old Output | New Output |
|-----------|-----------|
| `backup_vault_id` | `recovery_vault_id` |
| `backup_vault_name` | `recovery_vault_name` |
| `backup_vault_identity` | `recovery_vault_identity` |
| `redundancy_type` | `storage_mode_type` |
| `soft_delete_state` | `soft_delete_enabled` |
| N/A | `default_backup_policy_id` |

## Migration Steps

### Step 1: Review Current Configuration

If you have existing infrastructure using the old module, document your current settings:

```bash
# Export current state
terraform show -json > old-state.json

# Note your current variables
terraform output -json > old-outputs.json
```

### Step 2: Update Module Reference

**Before:**
```hcl
module "backup_vault" {
  source = "./terraform"

  name                = "bv-prod-001"
  location            = "eastus"
  resource_group_name = "rg-backup-prod"
  datastore_type      = "VaultStore"
  redundancy          = "GeoRedundant"
}
```

**After:**
```hcl
module "recovery_vault" {
  source = "./terraform"

  name                         = "rsv-prod-001"
  location                     = "eastus"
  resource_group_name          = "rg-backup-prod"
  sku                          = "Standard"
  storage_mode_type            = "GeoRedundant"
  create_default_backup_policy = true
}
```

### Step 3: Update Output References

**Before:**
```hcl
output "vault_id" {
  value = module.backup_vault.backup_vault_id
}
```

**After:**
```hcl
output "vault_id" {
  value = module.recovery_vault.recovery_vault_id
}
```

### Step 4: Handle State Migration

⚠️ **IMPORTANT**: This is a **destructive change**. The old Backup Vault resource will be destroyed and a new Recovery Services Vault will be created.

**Option A: Clean Migration (Recommended for new deployments)**
```bash
# Remove old state
terraform destroy -target=module.backup_vault

# Apply new configuration
terraform apply
```

**Option B: State Migration (For existing vaults with data)**
If you need to preserve existing backup data, you'll need to:
1. Create the new Recovery Services Vault separately
2. Manually migrate backup configurations
3. Remove the old Backup Vault after verification

⚠️ **Note**: Direct state migration between these resource types is not supported by Terraform.

### Step 5: Verify New Configuration

```bash
# Validate configuration
terraform validate

# Review plan
terraform plan

# Apply changes
terraform apply
```

## New Features Available

### Default VM Backup Policy

The new module can automatically create a default VM backup policy:

```hcl
module "recovery_vault" {
  source = "./terraform"
  
  # ... other configuration ...
  
  create_default_backup_policy = true  # Creates default policy
}
```

The default policy includes:
- **Daily backups** at 23:00
- **30 days** daily retention
- **12 weeks** weekly retention (Sundays)
- **12 months** monthly retention (First Sunday)
- **5 years** yearly retention (First Sunday of January)

### Enhanced Cross-Region Restore

Cross-region restore is now automatically enabled only when using GeoRedundant storage:

```hcl
storage_mode_type            = "GeoRedundant"
enable_cross_region_restore  = true  # Only works with GeoRedundant
```

## Testing Your Migration

1. **Validate syntax**: `terraform validate`
2. **Review plan**: `terraform plan -out=tfplan`
3. **Check for unexpected changes**: Review the plan carefully
4. **Apply in stages**: Consider applying to dev/test first
5. **Verify functionality**: Test backup and restore operations

## Rollback Plan

If you need to rollback:

1. Keep your old Terraform state files backed up
2. Maintain a copy of your old configuration
3. Document all manual changes made during migration

## Support Resources

- [Azure Recovery Services Vault Documentation](https://learn.microsoft.com/azure/backup/backup-azure-recovery-services-vault-overview)
- [Terraform azurerm_recovery_services_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault)
- [Azure Backup Architecture](https://learn.microsoft.com/azure/backup/backup-architecture)

## Questions?

If you encounter issues during migration, please:
1. Review the module README.md for updated documentation
2. Check the examples/ directory for reference configurations
3. Consult Azure documentation for service-specific guidance
