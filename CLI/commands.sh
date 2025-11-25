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

PowerShell Example (see /hardening-azure-backup-security/CLI/Delete_bofhbackup-vault01.ps1)

### Demo Part 3: Delete Recovery Services Vault with Multi User Authorization using Azure PowerShell not possible