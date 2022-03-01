  resource "azurerm_resource_group" "aks" {
    name     = var.resource_group
    location = var.location
  }

  module "aks-network" {
    source = "./modules/AKS-Network"
    subnet_name            = var.subnet_name
    vnet_name              = var.vnet_name
    resource_group_name    = azurerm_resource_group.aks.name
    subnet_cidr            = var.subnet_cidr
    pendpoint_subnetname   = var.pendpoint_subnetname
    pendpoint_cidr         = var.pendpoint_cidr
    appgw_subnetname       = var.appgw_subnetname
    appgw_cidr             = var.appgw_cidr
    location               = var.location
    address_space          = var.address_space
    network_security_group_name = var.network_security_group_name
  }

  module "acr" {
    source = "./modules/ACR"
    acr_name = var.acr_name
    depends_on = [azurerm_resource_group.aks]
  }

  module "aks-cluster" {
    source = "./modules/AKS-Cluster"
    cluster_name             = var.cluster_name
    location                 = var.location
    os_type                  = var.os_type
    dns_prefix               = var.dns_prefix
    resource_group           = azurerm_resource_group.aks.name
    node_count               = var.node_count
    os_disk_size_gb          = "40"
    max_pods                 = "50"
    vm_size                  = var.vm_size
    vnet_subnet_id           = module.aks-network.aks_subnet_id
    service_principal_client_id     = ""
    service_principal_client_secret = ""

    depends_on = [module.acr]
    
  }

  resource "azurerm_role_assignment" "resourcegroup_vnet" {
    principal_id = module.aks-cluster.identity
    scope = azurerm_resource_group.aks.id
    role_definition_name = "Contributor"
  }

  #ACR Role assignment

  resource "azurerm_role_assignment" "acrpull" {
    principal_id = module.aks-cluster.identity
    scope = module.acr.acr_id
    role_definition_name = "AcrPull"

    depends_on = [module.aks-cluster]
  }

  module "acr_private_dns_zone" {
    source = "./modules/PrivateDNSZone"
    private_dns_zone_name =  "privatelink.azurecr.io"
    resource_group_name = azurerm_resource_group.aks.name
    vnet_to_link = module.aks-network.aks_vnet_id 

    depends_on = [
      module.acr,
      module.aks-cluster
    ]
  }

  module "acr_private_endpoint" {
    source = "./modules/PrivateEndPoint"
    private_endpoint_name = "${module.acr.acr_name}-PrivateEndpoint"
    location = var.location
    resource_group_name = azurerm_resource_group.aks.name
    subnet_id = module.aks-network.pendpoint_subnetid
    private_connection_resource_id = module.acr.acr_id
    is_manual_connection = false
    subresource_name = "registry"
    private_dns_zone_group_name = "AcrPrivateDnsZoneGroup"
    private_dns_zone_group_ids = [module.acr_private_dns_zone.private_dns_zone_id]

    depends_on = [module.acr_private_dns_zone]
  }

  
#  module "nginx-ingress" {
#    source = "./modules/nginx-ingress"
#    resource_group_name = azurerm_resource_group.aks.name
#    cluster_name = var.cluster_name
#    depends_on = [module.aks-cluster]
#  }

  module "argo" {
    source = "./modules/ArgoCD"
    resource_group_name = azurerm_resource_group.aks.name
    cluster_name = var.cluster_name
    depends_on = [
      module.aks-cluster
      ]
  }