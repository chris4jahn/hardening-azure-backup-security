# Outputs for basic example

output "backup_vault_id" {
  description = "The ID of the backup vault"
  value       = module.backup_vault.backup_vault_id
}

output "backup_vault_name" {
  description = "The name of the backup vault"
  value       = module.backup_vault.backup_vault_name
}

output "backup_vault_identity" {
  description = "The managed identity of the backup vault"
  value       = module.backup_vault.backup_vault_identity
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.example.name
}
