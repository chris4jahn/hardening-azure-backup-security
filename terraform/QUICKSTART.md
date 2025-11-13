# Azure Backup Vault Terraform Module - Quick Start

## Module Structure

```
terraform/
├── README.md                          # Comprehensive module documentation
├── LICENSE                            # MIT License
├── .gitignore                         # Terraform-specific ignores
├── main.tf                            # Backup vault resource definition
├── variables.tf                       # Input variables (alphabetical)
├── outputs.tf                         # Output values (alphabetical)
├── providers.tf                       # Provider requirements
├── examples/                          # Usage examples
│   ├── basic/                         # Basic configuration
│   │   ├── README.md
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── hardened/                      # Hardened security config
│       ├── README.md
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── tests/                             # Terraform tests
    └── backup_vault.tftest.hcl        # Unit tests
```

## Provider Version

- **azurerm**: >= 4.0.0 (Latest: 4.52.0)
- **Terraform**: >= 1.5.0

## Quick Start

### 1. Basic Usage

```hcl
module "backup_vault" {
  source = "./terraform"

  name                = "bv-prod-001"
  location            = "eastus"
  resource_group_name = "rg-backup-prod"

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
```

### 2. Hardened Configuration

```hcl
module "backup_vault" {
  source = "./terraform"

  name                        = "bv-prod-hardened-001"
  location                    = "eastus"
  resource_group_name         = "rg-backup-prod"
  redundancy                  = "GeoRedundant"
  enable_cross_region_restore = true
  soft_delete_retention_days  = 90

  tags = {
    Environment = "Production"
    Security    = "Hardened"
  }
}
```

## Key Features

✅ **Security Hardening**
- Soft delete with configurable retention (14-180 days)
- Cross-region restore for disaster recovery
- Geo-redundant storage
- System-assigned managed identity

✅ **Flexibility**
- Three redundancy options: LocallyRedundant, ZoneRedundant, GeoRedundant
- Configurable soft delete retention
- Optional cross-region restore

✅ **Best Practices**
- Follows Terraform module standards
- Comprehensive validation rules
- Alphabetically ordered variables/outputs
- Complete test coverage

## Testing

Run the included Terraform tests:

```bash
cd terraform
terraform test
```

Tests validate:
- Default configuration
- Redundancy options
- Soft delete configurations
- Cross-region restore
- Managed identity
- Tag application
- Hardened configuration

## Next Steps

1. **Initialize**: `terraform init`
2. **Validate**: `terraform validate`
3. **Format**: `terraform fmt -recursive`
4. **Test**: `terraform test`
5. **Plan**: `terraform plan`
6. **Apply**: `terraform apply`

## Documentation

See the main [README.md](./README.md) for:
- Complete input/output reference
- Security hardening details
- Example configurations
- Provider requirements

## Support

For issues or questions, please refer to:
- [Azure Backup Vault Documentation](https://learn.microsoft.com/azure/backup/backup-azure-recovery-services-vault-overview)
- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
