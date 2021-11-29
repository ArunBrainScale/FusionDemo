resource "null_resource" "nginx-ingress" {
    provisioner "local-exec" {
        command = <<EOT
          az aks command invoke -g ${var.resource_group_name} -n ${var.cluster_name} -c "helm repo add nginx-ingress https://kubernetes.github.io/ingress-nginx && helm repo update && helm install nginx-ingress nginx-ingress/ingress-nginx --create-namespace --namespace nginx-ingress" -o none
        EOT
        interpreter = ["PowerShell", "-Command"]
    }
  }