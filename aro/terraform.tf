terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate01"
    storage_account_name = "tfstate01sding"
    container_name       = "tfstate"
    key                  = "sding-aro-cluster.terraform.tfstate"
  }
}

provider "azurerm" {
   features {}
}