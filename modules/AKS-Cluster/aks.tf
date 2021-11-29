
data "azurerm_subscription" "current" {}
#data "azurerm_subnet" "appgw" {
  #id = var.appgw_subnetid
#  name = var.appgwsubnetname
#  resource_group_name = var.resource_group
#  virtual_network_name = var.vnet_name
#}

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
    }

    identity {
      type = "SystemAssigned"
    }

    #addon_profile {
    #  ingress_application_gateway {
    #    enabled = true
        #subnet_cidr = var.appgwsubnet_cidr
    #    subnet_id = data.azurerm_subnet.appgw.id
    #  }
    #}

    network_profile {
      network_plugin = var.network_plugin
      docker_bridge_cidr = var.docker_network_cidr
      network_policy = var.network_policy
      dns_service_ip = var.dns_service_ip
      service_cidr = var.service_cidr
    }

    role_based_access_control {
      azure_active_directory {
        admin_group_object_ids = ["cc673a7c-f67a-4700-84e0-b9ec9dbde268"]
        tenant_id = data.azurerm_subscription.current.tenant_id
        managed = true
      }
      enabled = true
    }

    #depends_on = [azuread_group.aks-aad-clusteradmins]

  }

