# terraform-azurerm-tfstate-backend 

## Usage

### Create

Download Terrform modules and providers:

```
terraform init
```

Create the remote state backend in Azure Storage Container with related local backend configuration file and all other resources:

```
terraform apply
```

Now that the state is stored in the local filesystem backend, move it to the remote backend, by running:

```
terraform init -force-copy
```

### Destroy

Set `terraform_remote_state_backend_config_file_path` input variable's value to "" (empty string), in order to remove the `terraform_backend.tf` local config file.

```
terraform apply -target module.terraform_remote_state_backend
```

Then move the state from the remote backend to the local filesystem backend:

```
terraform init -force-copy
```

### Unlock the Terraform Azure remote state backend destroy prevention

This is a workaround due to [thie issue](https://github.com/hashicorp/terraform/issues/22544): disable destroy prevention in the Storage Account and Storage Container resources, by manually setting `prevent_destroy` to false in the `lifecycle` block for each resource of the module (`.terraform/modules/terraform-azurerm-tfstate-backend` file):

```
resource "azurerm_storage_container" "main" {

  # [...]

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_storage_account" "main" {

  # [...]

  lifecycle {
    prevent_destroy = false
  }
}
```

Now the remote state backend and all the resources can be removed:

```
terraform destroy
```

Verify that the local `terraform.tfstate` file now contains no resources.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.23 |
| azurerm | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.0.0 |
| local | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_tier | n/a | `string` | `"standard"` | no |
| config\_file\_name | n/a | `string` | `"terraform_backend.tf"` | no |
| config\_file\_path | n/a | `string` | `"."` | no |
| config\_template\_file | The path to the template used to generate the config file | `string` | `""` | no |
| key | n/a | `string` | `"tfstate"` | no |
| location | Azure region (e.g. westus2) | `any` | n/a | yes |
| resource\_group\_name | Name of resource group | `any` | n/a | yes |
| storage\_account\_name | Storage account name (NOTE: can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long) | `any` | n/a | yes |
| storage\_account\_replication\_type | n/a | `string` | `"LRS"` | no |
| storage\_container\_name | Name of the storage container | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| container-name | n/a |
| resource-group-name | n/a |
| storage-account-name | n/a |
| storage\_account\_id | n/a |

