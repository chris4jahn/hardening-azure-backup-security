### Demo Part 1: Create and List Recovery Services Vaults
# create a resource group named rg-bofh-backup
az group create --name rg-bofh-backup --location swedencentral 

# Create a Recovery Services vault
az backup vault create --resource-group rg-bofh-backup --name bofh-rsvault03 --location swedencentral

Copilot: 
I want to delete bofh-rsvault03 in RG rg-bofh-backup. Generate an Azure CLI command for that
CLI
az backup vault delete --name bofh-rsvault03 --resource-group rg-bofh-backup --yes 



### Demo Part 2: Delete Recovery Services Vault with Protected Items using Azure PowerShell
Copilot: 
I want to delete bofh-rsvault02. There are protected items in the recovery service vault. How can I delete the vault using Azure PowerShell? I want to fill in all names using get commands or foreach loops. Fill in SubscriptionId and the conatiner name for each protected item. Add BackupManagementType and Workloadtype AzureVM for the items. I want to copy and paste it directly to the Azure cloud shell
PowerShell:

                        # Delete all backup items in Recovery Services Vault
                        Write-Host "Switching to subscription $subscriptionId..." -ForegroundColor Cyan
                        Set-AzContext -SubscriptionId <your-subscription-id>
                
                        Write-Host "Deleting all backup items in vault $vaultId..." -ForegroundColor Yellow
                        $backupItemsVM = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureVM -WorkloadType AzureVM -VaultId /subscriptions/<your-subscription-id>
                /resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01
                        $backupItemsSQL = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureWorkload -WorkloadType MSSQL -VaultId /subscriptions/<your-subscription-id>
                /resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01
                        $backupItemsAFS = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureStorage -WorkloadType AzureFiles -VaultId /subscriptions/<your-subscription-id>
                /resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01
                        $backupItemsSAP = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureWorkload -WorkloadType SAPHanaDatabase -VaultId /subscriptions/<your-subscription-id>
                /resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01
                        foreach ($item in $backupItemsVM) {
                                Write-Host "Removing VM backup item: $($item.Name)" -ForegroundColor DarkYellow
                                Disable-AzRecoveryServicesBackupProtection -Item $item -VaultId /subscriptions/<your-subscription-id>
                        /resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01 -RemoveRecoveryPoints -Force
                        }
                        foreach ($item in $backupItemsSQL) {
                                Write-Host "Removing SQL backup item: $($item.Name)" -ForegroundColor DarkYellow
                                Disable-AzRecoveryServicesBackupProtection -Item $item -VaultId /subscriptions/<your-subscription-id>
                        /resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01 -RemoveRecoveryPoints -Force
                        }
                        foreach ($item in $backupItemsSAP) {
                                Write-Host "Removing SAP HANA backup item: $($item.Name)" -ForegroundColor DarkYellow
                                Disable-AzRecoveryServicesBackupProtection -Item $item -VaultId /subscriptions/<your-subscription-id>
                        /resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01 -RemoveRecoveryPoints -Force
                        }
                        foreach ($item in $backupItemsAFS) {
                                Write-Host "Removing Azure Files backup item: $($item.Name)" -ForegroundColor DarkYellow
                                Disable-AzRecoveryServicesBackupProtection -Item $item -VaultId /subscriptions/<your-subscription-id>
                        /resourceGroups/bofh-backupvault01/providers/Microsoft.RecoveryServices/vaults/bofhbackup-vault01 -RemoveRecoveryPoints -Force
                        }
                        Write-Host "All backup items deleted." -ForegroundColor Green
                
