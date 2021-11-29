  output "aks_subnet_id" {
    value = azurerm_subnet.subnet.id
  }
  output "aks_vnet_id" {
    value = azurerm_virtual_network.network.id
  }
  output "pendpoint_subnetid" {
    value = azurerm_subnet.privateendpoints.id
  }