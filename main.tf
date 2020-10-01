locals {
  config_file_count = var.config_file_path != "" ? 1 : 0
  config_file = format(
    "%s/%s",
    var.config_file_path,
    var.config_file_name
  )
  config_template_file = var.config_template_file != "" ? var.config_template_file : "${path.module}/templates/terraform_backend.tf.tpl"
}


resource "azurerm_storage_container" "main" {
  name                 = var.storage_container_name
  storage_account_name = azurerm_storage_account.main.name

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  location                 = var.location
  account_tier             = var.account_tier
  resource_group_name      = azurerm_resource_group.main.name
  account_replication_type = var.storage_account_replication_type

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

data "template_file" "config" {
  template = file(local.config_template_file)

  vars = {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.storage_container_name
    key                  = var.key
  }
}

resource "local_file" "config" {
  count           = local.config_file_count
  content         = data.template_file.config.rendered
  filename        = local.config_file
  file_permission = "0644"
}

