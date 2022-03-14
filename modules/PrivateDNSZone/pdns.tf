resource "azurerm_private_dns_zone" "private_dns_zone" {

    name = var.private_dns_zone_name
    resource_group_name = var.resource_group_name
  
}

resource "azurerm_private_dns_zone_virtual_network_link" "plink" {

    name = "link_to_${lower("aks")}"
    resource_group_name = var.resource_group_name
    private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
    virtual_network_id = var.vnet_to_link
  
}