  output "k8shostname" {
    value = module.aks-cluster.k8shostname
    sensitive = false
  }