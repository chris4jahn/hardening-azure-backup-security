# Outputs for hardened example

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

output "cross_region_restore_enabled" {
  description = "Whether cross-region restore is enabled"
  value       = module.backup_vault.cross_region_restore_enabled
}

output "redundancy_type" {
  description = "The redundancy type configured"
  value       = module.backup_vault.redundancy_type
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.example.name
}
