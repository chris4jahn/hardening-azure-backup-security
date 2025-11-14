az account set --subscription 33d063dc-2392-4d6f-ba58-3128b84aa2fc 

az backup vault create --resource-group bofh-backupvault01 --name bofhbackup-vault01 --location swedencentral --subscription sub-mvp-cf-2025 --output table

Copilot: 
I want to create another recovery service vault named bofh-rs-vault111125 in the same resource group bofh-backupvault01. Generate the Azure CLI command for that
az backup vault create --resource-group bofh-backupvault01 --name bofh-rs-vault111125 --location swedencentral --subscription sub-mvp-cf-2025 --output table

az backup vault list --output table

Copilot: 
I want to delete bofh-rs-vault111125. Generate an Azure CLI command for that
CLI
az backup vault delete --name bofh-rs-vault111125 --resource-group bofh-backupvault01 --yes 

az backup vault delete --name bofhbackup-vault01 --resource-group bofh-backupvault01 --yes 

Copilot:
whats the cli command to get my container
CLI:
az backup container list --resource-group bofh-backupvault01 --vault-name bofhbackup-vault01 --backup-management-type AzureIaaSVM

Copilot:
How do I recover a deleted Recovery Services vault?


Copilot: 
I want to delete bofhbackup-vault01. There are protected items in the recovery service vault. How can I delete the vault using Azure PowerShell? I want to fill in all names using get commands or foreach loops. Fill in SubscriptionId and the conatiner name for each protected item. Add BackupManagementType and Workloadtype AzureVM for the items. I want to copy and paste it directly to the Azure cloud shell
PowerShell:

                        # Delete all backup items in Recovery Services Vault
                        Write-Host "Switching to subscription $subscriptionId..." -ForegroundColor Cyan
                        Set-AzContext -SubscriptionId 33d063dc-2392-4d6f-ba58-3128b84aa2fc
                        Write-Host "Deleting all backup items in vault $vaultId..." -ForegroundColor Yellow
                        $backupItemsVM = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureVM -WorkloadType AzureVM -VaultId /subscriptions/33d063dc-2392-4d6f-ba58-3128b84aa2fc/resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01
                        $backupItemsSQL = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureWorkload -WorkloadType MSSQL -VaultId /subscriptions/33d063dc-2392-4d6f-ba58-3128b84aa2fc/resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01
                        $backupItemsAFS = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureStorage -WorkloadType AzureFiles -VaultId /subscriptions/33d063dc-2392-4d6f-ba58-3128b84aa2fc/resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01
                        $backupItemsSAP = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureWorkload -WorkloadType SAPHanaDatabase -VaultId /subscriptions/33d063dc-2392-4d6f-ba58-3128b84aa2fc/resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01
                        foreach ($item in $backupItemsVM) {
                                Write-Host "Removing VM backup item: $($item.Name)" -ForegroundColor DarkYellow
                                Disable-AzRecoveryServicesBackupProtection -Item $item -VaultId /subscriptions/33d063dc-2392-4d6f-ba58-3128b84aa2fc/resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01 -RemoveRecoveryPoints -Force
                        }
                        foreach ($item in $backupItemsSQL) {
                                Write-Host "Removing SQL backup item: $($item.Name)" -ForegroundColor DarkYellow
                                Disable-AzRecoveryServicesBackupProtection -Item $item -VaultId /subscriptions/33d063dc-2392-4d6f-ba58-3128b84aa2fc/resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01 -RemoveRecoveryPoints -Force
                        }
                        foreach ($item in $backupItemsSAP) {
                                Write-Host "Removing SAP HANA backup item: $($item.Name)" -ForegroundColor DarkYellow
                                Disable-AzRecoveryServicesBackupProtection -Item $item -VaultId /subscriptions/33d063dc-2392-4d6f-ba58-3128b84aa2fc/resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01 -RemoveRecoveryPoints -Force
                        }
                        foreach ($item in $backupItemsAFS) {
                                Write-Host "Removing Azure Files backup item: $($item.Name)" -ForegroundColor DarkYellow
                                Disable-AzRecoveryServicesBackupProtection -Item $item -VaultId /subscriptions/33d063dc-2392-4d6f-ba58-3128b84aa2fc/resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01 -RemoveRecoveryPoints -Force
                        }
                        Write-Host "All backup items deleted." -ForegroundColor Green
                
Set-AzContext -Subscription 33d063dc-2392-4d6f-ba58-3128b84aa2fc 