variable "location" {
  description = "Azure region (e.g. westus2)"
}

variable "resource_group_name" {
  description = "Name of resource group"
}

variable "account_tier" {
  default = "standard"
}

variable "storage_account_replication_type" {
  default = "LRS"
}

variable "storage_account_name" {
  description = "Storage account name (NOTE: can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long)"
}

variable "storage_container_name" {
  description = "Name of the storage container"
}

variable "key" {
  default = "tfstate"
}

variable "config_file_path" {
  default = "."
}

variable "config_file_name" {
  default = "terraform_backend.tf"
}

variable "config_template_file" {
  default     = ""
  description = "The path to the template used to generate the config file"
}
