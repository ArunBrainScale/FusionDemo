resource "null_resource" "argo" {
    provisioner "local-exec" {
        command = <<EOT
          az aks command invoke -g ${var.resource_group_name} -n ${var.cluster_name} -c "kubectl create ns argocd && helm repo add argo https://argoproj.github.io/argo-helm && helm repo update && helm install argo argo/argo-cd -n argocd" -o none
        EOT
        interpreter = ["PowerShell", "-Command"]
    }
  }