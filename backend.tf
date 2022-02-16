terraform {
  backend "azurerm" {
    resource_group_name  = "DerekZ_tf_backend"
    storage_account_name = "storageaccount4backend"
    container_name       = "con"
    key                  = "key"
  }
}
