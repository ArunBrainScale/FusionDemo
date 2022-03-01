variable "service_principal_client_id" {
    description = "The Client ID for the Service Principal"
  }

  variable "service_principal_client_secret" {
     description = "The Client Secret for the Service Principal"
  }

  variable "cluster_name" {
     description = "Cluster Name"
  }

  variable "resource_group" {
     description = "Resoruce Group Name"
  }

  variable "location" {

  }
  variable "dns_prefix" {
    description = "DNS Prefix"
  }

  variable "api_server_authorized_ip_ranges" {
    description = "ip ranges to lock down access to kubernetes api server"
    default     = "0.0.0.0/0"
  }

  # Node Pool config
  variable "agent_pool_name" {
    description = "name for the agent pool profile"
    default     = "demopool"
  }

  variable "agent_pool_type" {
    description = "type of the agent pool (AvailabilitySet and VirtualMachineScaleSets)"
    default     = "VirtualMachineScaleSets"
  }

  variable "node_count" {
    description = "number of nodes to deploy"
  }

  variable "vm_size" {
    description = "size/type of VM to use for nodes"
  }

  variable "os_type" {
    description = "type of OS to run on nodes"
  }

  variable "os_disk_size_gb" {
    description = "size of the OS disk to attach to the nodes"
  }

  variable "vnet_subnet_id" {
    description = "vnet id where the nodes will be deployed"
  }

  variable "max_pods" {
    description = "maximum number of pods that can run on a single node"
  }

  variable "network_plugin" {
    description = "network plugin for kubenretes network overlay (azure or calico)"
    default     = "azure"
  }

  variable "service_cidr" {
    description = "kubernetes internal service cidr range"
    default     = "10.0.0.0/16"
  }

  variable "network_policy" {
    default = "azure"
  }

  variable "dns_service_ip" {
    default = "10.0.0.10"
  }

  variable "docker_network_cidr" {
    default = "172.17.0.1/16"
  }

  variable "kubernetes_version" {
    default = "1.21.9"
  }

  variable "vnet_name" {
    description = "name of the vnet that this subnet will belong to"
    default = "AKS-vnet"
  }

  variable "appgw_subnetname" {
    default = "appgw-Subnet"
  }