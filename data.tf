data "azurerm_client_config" "current"{
    
}

data "azurerm_resource_group" "rg" {
  name = "rg-danielmentoring-dev"
}

data "azuread_client_config" "current" {}