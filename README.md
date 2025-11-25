# Hardening Azure Backup Security

A comprehensive guide and toolset for implementing and managing secure Azure Backup solutions with hardened configurations and proper security practices.

## 📋 Overview

This repository provides Infrastructure as Code (IaC) templates, CLI scripts, and best practices for deploying and managing Azure Recovery Services Vaults with enterprise-grade security hardening. It demonstrates proper backup vault configuration, security controls, and deletion procedures for protected resources.

## 🎯 Features

- **Azure CLI Scripts**: Automated vault creation, configuration, and deletion workflows
- **PowerShell Scripts**: Scripts for handling vaults with protected items
- **Security Best Practices**: Soft delete, cross-region restore, and geo-redundancy
- **Protected Item Management**: Scripts for handling vaults with protected items
- **Multi-User Authorization**: Guidance for MUA-enabled vault operations

## 📁 Repository Structure

```
hardening-azure-backup-security/
├── README.md                    # This file
├── LICENSE                      # MIT License
├── CLI/                         # Azure CLI and PowerShell scripts
│   ├── commands.sh             # Vault creation and deletion commands
│   └── Delete_bofhbackup-vault01.ps1  # PowerShell vault cleanup script
└── Media/                       # slides
```

## 🚀 Quick Start

### Prerequisites

- Azure subscription with appropriate permissions
- Azure CLI or PowerShell installed

### Using Azure CLI

1. **Create a resource group**:
   ```bash
   az group create --name rg-backup-prod --location swedencentral
   ```

2. **Create a Recovery Services vault**:
   ```bash
   az backup vault create \
     --resource-group rg-backup-prod \
     --name rsv-prod-001 \
     --location swedencentral
   ```

3. **Configure vault properties**:
   ```bash
   # Enable soft delete
   az backup vault backup-properties set \
     --name rsv-prod-001 \
     --resource-group rg-backup-prod \
     --soft-delete-feature-state Enable
   ```

See [CLI/commands.sh](CLI/commands.sh) for more examples.

## 🔒 Security Features

### Implemented Security Controls

1. **Soft Delete Protection**
   - Configurable retention (14+ days)
   - Protects against accidental deletion
   - Recoverable deleted items

2. **Cross-Region Restore**
   - Disaster recovery capability
   - Restore from secondary region
   - Available with GeoRedundant storage

3. **Storage Redundancy Options**
   - **GeoRedundant**: Data replicated across regions
   - **ZoneRedundant**: Data replicated across zones
   - **LocallyRedundant**: Data replicated locally

4. **System-Assigned Managed Identity**
   - Secure access to Azure resources
   - No credential management required
   - Azure RBAC integration

5. **Default Backup Policies**
   - Daily backups at 23:00
   - 30-day daily retention
   - 12-week weekly retention
   - 12-month monthly retention
   - 5-year yearly retention

### Multi-User Authorization (MUA)

For enhanced security in production environments, enable Multi-User Authorization:

```bash
az backup vault create \
  --resource-group rg-backup-prod \
  --name rsv-prod-001 \
  --location swedencentral \
  --multi-user-authorization Enabled
```

**Note**: Vaults with MUA enabled require additional authorization for critical operations.

## 📖 Usage Examples

### Deleting a Vault with Protected Items (PowerShell)

When a vault contains protected items, you must first disable protection and delete backup data:

```powershell
# See CLI/Delete_bofhbackup-vault01.ps1 for complete script

# 1. Get all backup items
$backupItems = Get-AzRecoveryServicesBackupItem `
  -BackupManagementType AzureVM `
  -WorkloadType AzureVM `
  -VaultId $vault.ID

# 2. Disable protection and delete data
foreach ($item in $backupItems) {
  Disable-AzRecoveryServicesBackupProtection `
    -Item $item `
    -VaultId $vault.ID `
    -RemoveRecoveryPoints `
    -Force
}

# 3. Delete the vault
Remove-AzRecoveryServicesVault -Vault $vault
```

## 📚 Documentation

- **[Azure Backup Documentation](https://learn.microsoft.com/azure/backup/)** - Official Microsoft documentation

## 🔧 Troubleshooting

### Common Issues

**Issue**: Cannot delete vault with protected items

**Solution**: Use the provided PowerShell script to disable protection and remove recovery points first.

---

**Issue**: Cross-region restore not available

**Solution**: Ensure `storage_mode_type` is set to `GeoRedundant`. Cross-region restore only works with geo-redundant storage.

---

**Issue**: Multi-User Authorization blocking operations

**Solution**: MUA requires additional authorization from designated approvers. Coordinate with your security team or disable MUA if not required.

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Resources

- [Azure Backup Architecture](https://learn.microsoft.com/azure/backup/backup-architecture)
- [Recovery Services Vault Overview](https://learn.microsoft.com/azure/backup/backup-azure-recovery-services-vault-overview)
- [Azure Backup Security Features](https://learn.microsoft.com/azure/backup/backup-azure-security-feature)

## 📧 Support

For issues and questions:

- Open an issue in this repository
- Review Azure Backup documentation

## 🏷️ Tags

`azure` `backup` `recovery-services` `security` `disaster-recovery` `azure-cli` `powershell`

---

**Last Updated**: November 2025
