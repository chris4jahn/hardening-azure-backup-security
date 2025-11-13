# Basic Azure Backup Vault Example

This example demonstrates a basic Azure Backup Vault configuration with default security settings.

## Features

- Basic backup vault with GeoRedundant storage
- Cross-region restore enabled
- Soft delete with 14-day retention
- Immutability protection enabled

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

  name                = "bv-example-001"
  location            = "eastus"
  resource_group_name = "rg-backup-example"

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
```
