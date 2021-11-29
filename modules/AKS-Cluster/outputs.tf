 output "azurerm_kubernetes_cluster_id" {
    value = azurerm_kubernetes_cluster.cluster.id
  }

  output "azurerm_kubernetes_cluster_fqdn" {
    value = azurerm_kubernetes_cluster.cluster.fqdn
  }

  output "azurerm_kubernetes_cluster_node_resource_group" {
    value = azurerm_kubernetes_cluster.cluster.node_resource_group
  }

  output "client_key" {
    value = azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_key
  }

  output "client_certificate" {
    value = azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_certificate
  }

  output "cluster_ca_certificate" {
    value = azurerm_kubernetes_cluster.cluster.kube_admin_config.0.cluster_ca_certificate
  }

  output "k8shostname" {
    value = azurerm_kubernetes_cluster.cluster.kube_admin_config[0].host
  }

  output "kube_config" {
    value = azurerm_kubernetes_cluster.cluster.kube_config_raw
  }

  #output "clusteradmin" {
  #  value = azuread_group.aks-aad-clusteradmins.id
  #}

  output "kubeletIdentity" {
    value = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  }

  output "identity" {
    value = azurerm_kubernetes_cluster.cluster.identity[0].principal_id
  }