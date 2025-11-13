# Output values for Azure Recovery Services Vault module
# Outputs are listed in alphabetical order

output "default_backup_policy_id" {
  description = "The ID of the default backup policy (if created)"
  value       = var.create_default_backup_policy ? azurerm_backup_policy_vm.default[0].id : null
}

output "recovery_vault_id" {
  description = "The ID of the recovery services vault"
  value       = azurerm_recovery_services_vault.this.id
}

output "recovery_vault_identity" {
  description = "The managed identity configuration of the recovery services vault"
  value = {
    principal_id = azurerm_recovery_services_vault.this.identity[0].principal_id
    tenant_id    = azurerm_recovery_services_vault.this.identity[0].tenant_id
    type         = azurerm_recovery_services_vault.this.identity[0].type
  }
}

output "recovery_vault_name" {
  description = "The name of the recovery services vault"
  value       = azurerm_recovery_services_vault.this.name
}

output "soft_delete_enabled" {
  description = "Whether soft delete is enabled for the recovery services vault"
  value       = azurerm_recovery_services_vault.this.soft_delete_enabled
}

output "storage_mode_type" {
  description = "The storage mode type configured for the recovery services vault"
  value       = azurerm_recovery_services_vault.this.storage_mode_type
}
