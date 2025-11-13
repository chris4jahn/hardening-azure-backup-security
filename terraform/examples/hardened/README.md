# Hardened Azure Backup Vault Example

This example demonstrates a fully hardened Azure Backup Vault configuration with maximum security settings.

## Features

- GeoRedundant storage for cross-region availability
- Cross-region restore enabled for disaster recovery
- Extended soft delete retention (90 days)
- Comprehensive tagging for governance
- System-assigned managed identity

## Security Hardening

This configuration implements all available security features:

1. **Geo-Redundancy**: Ensures data is replicated across regions
2. **Cross-Region Restore**: Enables recovery from secondary region
3. **Extended Soft Delete**: 90-day retention for deleted backups
4. **Managed Identity**: System-assigned identity for secure access
5. **Comprehensive Tagging**: Supports governance and compliance requirements

## Usage

1. Update the `terraform.tfvars` file with your values
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Review the plan:
   ```bash
   terraform plan
   ```
4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Example Configuration

```hcl
module "backup_vault" {
  source = "../../"

  name                = "bv-prod-hardened-001"
  location            = "eastus"
  resource_group_name = "rg-backup-prod"

  redundancy                  = "GeoRedundant"
  enable_cross_region_restore = true
  soft_delete_retention_days  = 90

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Security    = "Hardened"
    Compliance  = "Required"
  }
}
```
