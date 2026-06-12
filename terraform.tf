terraform {
  backend "azurerm" {
    resource_group_name  = "rg-danielmentoring-dev"
    storage_account_name = "mentoringtfstate"
    container_name       = "tfstate"                 
    key                  = "infra/abs-dev.tfstate"   
    use_azuread_auth     = true                      
  }

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "=0.1.0"
    }
  }

}