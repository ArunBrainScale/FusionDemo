
data "azurerm_subscription" "current" {}

data "azurerm_subnet" "appgw" {
  #id = var.appgw_subnetid
  name = var.appgw_subnetname
  resource_group_name = var.resource_group
  virtual_network_name = var.vnet_name
}

data "azuread_group" "admin_group" {
  display_name = "aks-rbac-aks-fusion"
}


  resource "azurerm_kubernetes_cluster" "cluster" {
    name = var.cluster_name
    location = var.location
    resource_group_name = var.resource_group
    dns_prefix = var.dns_prefix
    kubernetes_version = var.kubernetes_version
    private_cluster_enabled = true
    

    default_node_pool {
      name       = var.agent_pool_name
      node_count = var.node_count
      vm_size    = var.vm_size
      vnet_subnet_id = var.vnet_subnet_id
      os_disk_size_gb = var.os_disk_size_gb
      type = var.agent_pool_type
      enable_auto_scaling = true
      max_count = 3
      min_count = 2
      availability_zones = [1,2]
      only_critical_addons_enabled = true
    }

    identity {
      type = "SystemAssigned"
    }

    addon_profile {
      ingress_application_gateway {
        enabled = true
        #subnet_cidr = var.appgwsubnet_cidr
        subnet_id = data.azurerm_subnet.appgw.id
      }
    }

    network_profile {
      network_plugin = var.network_plugin
      docker_bridge_cidr = var.docker_network_cidr
      network_policy = var.network_policy
      dns_service_ip = var.dns_service_ip
      service_cidr = var.service_cidr
    }

    role_based_access_control {
      azure_active_directory {
        admin_group_object_ids = [data.azuread_group.admin_group.object_id]
        tenant_id = data.azurerm_subscription.current.tenant_id
        managed = true
      }
      enabled = true
    }

    #depends_on = [azuread_group.aks-aad-clusteradmins]
  }

  resource "azurerm_kubernetes_cluster_node_pool" "additional_pools" {

    for_each = var.additional_pools

    kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
    name = each.value.node_os == "Linux" ? substr(each.key, 0, 12) : substr(each.key, 0, 6)
    orchestrator_version  = var.kubernetes_version
    node_count            = each.value.node_count
    vm_size               = each.value.vm_size
    availability_zones    = each.value.zones
    max_pods              = 50
    os_disk_size_gb       = 128
    os_type               = each.value.node_os
    vnet_subnet_id        = var.vnet_subnet_id
    node_labels           = each.value.labels
    #node_taints           = each.value.taints
    enable_auto_scaling   = each.value.cluster_auto_scaling
    min_count             = each.value.cluster_auto_scaling_min_count
    max_count             = each.value.cluster_auto_scaling_max_count
    enable_node_public_ip = false
 }

