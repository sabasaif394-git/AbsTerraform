resource "azurerm_storage_account" "example" {
    name = "absmentoring"
    resource_group_name = data.azurerm_resource_group.rg.name
    location = data.azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "GRS"
    allow_nested_items_to_be_public = false
  
    network_rules {
        default_action             = "Deny"
        ip_rules                   = local.relex_ips
        bypass                     = ["Metrics", "AzureServices", "Logging"]
        virtual_network_subnet_ids = ["/subscriptions/a18d6bf2-3d6f-4b77-b71c-5f2e51300ca0/resourceGroups/gitlab-runners-ct-prod/providers/Microsoft.Network/virtualNetworks/gitlab-runners-ct-prod/subnets/gitlab-runners-ct-prod-kubesubnet"]
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "input"
  storage_account_id    = azurerm_storage_account.example.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "access"{
  scope = azurerm_storage_account.example.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id = local.access_group_id
}

resource "azurerm_role_assignment" "sp_access"{
  scope = azurerm_storage_account.example.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id = data.azurerm_client_config.current.object_id
}
