output "storage-account-name" {
  value = "${azurerm_storage_account.main.name}"
}

output "resource-group-name" {
  value = "${azurerm_resource_group.main.name}"
}

output "container-name" {
  value = "${azurerm_storage_container.main.name}"
}

output "storage_account_id" {
  value = "${azurerm_storage_account.main.id}"
}
