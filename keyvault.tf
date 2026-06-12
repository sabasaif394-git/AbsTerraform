resource "azurerm_key_vault" "example" {
    name = "absmentoring"
    resource_group_name = data.azurerm_resource_group.rg.name
    location = data.azurerm_resource_group.rg.location
    tenant_id = data.azurerm_client_config.current.tenant_id
    sku_name = "standard"

    network_acls {
        default_action             = "Deny"
        ip_rules                   = local.relex_ips
        bypass                     = "AzureServices"
        virtual_network_subnet_ids = ["/subscriptions/a18d6bf2-3d6f-4b77-b71c-5f2e51300ca0/resourceGroups/gitlab-runners-ct-prod/providers/Microsoft.Network/virtualNetworks/gitlab-runners-ct-prod/subnets/gitlab-runners-ct-prod-kubesubnet"]
  }
}

