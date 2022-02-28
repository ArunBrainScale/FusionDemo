  resource "azurerm_virtual_network" "network" {
    name                = var.vnet_name
    location            = var.location
    resource_group_name = var.resource_group_name
    address_space       = [var.address_space]
  }

  resource "azurerm_subnet" "subnet" {
    name                      = var.subnet_name
    resource_group_name       = var.resource_group_name
    virtual_network_name      = azurerm_virtual_network.network.name
    address_prefixes = [var.subnet_cidr]
  }

 resource "azurerm_subnet" "privateendpoints" {
    name = var.pendpoint_subnetname
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.network.name
    address_prefixes = [var.pendpoint_cidr]
    enforce_private_link_endpoint_network_policies = true
    enforce_private_link_service_network_policies = false
  }

resource "azurerm_subnet" "appgw" {
    name = var.appgw_subnetname
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.network.name
    address_prefixes = [var.appgw_cidr]
  }


  resource "azurerm_network_security_group" "sg" {
    name                = var.network_security_group_name
    location            = var.location
    resource_group_name = var.resource_group_name

    security_rule {
      name                       = "HTTPS"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    security_rule {
      name                       = "HTTP"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  resource "azurerm_subnet_network_security_group_association" "network-security" {
    network_security_group_id = azurerm_network_security_group.sg.id
    subnet_id = azurerm_subnet.subnet.id
  }
