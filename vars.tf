
  variable "cluster_name" {
    description = "Cluster Name"
    default = "Demo-AKS_Updated"
  }

  variable "resource_group" {
    description = "Resoruce Group Name"
    default = "AKS_updated"
  }

  variable "location" {
    description = "Location"
    default = "eastus"
  }

  variable "dns_prefix" {
    description = "DNS Prefix"
    default = "Demo-AKSupdated"
  }

  variable "api_server_authorized_ip_ranges" {
    description = "ip ranges to lock down access to kubernetes api server"
    default     = "0.0.0.0/0"
  }

  # Node Pool config

  variable "node_count" {
    description = "number of nodes to deploy"
    default = "2"
  }

  variable "vm_size" {
    description = "size/type of VM to use for nodes"
    default = "Standard_DS2_v2"
  }

  variable "os_type" {
    description = "type of OS to run on nodes"
    default = "Linux"
  }

  variable "os_disk_size_gb" {
    description = "size of the OS disk to attach to the nodes"
    default = "40"
  }

  variable "max_pods" {
    description = "maximum number of pods that can run on a single node"
    default = "110"
  }

  variable "address_space" {
    type = string
    description = "The address space that is used the virtual network"
    default     = "10.1.0.0/16"
  }

  variable "kubernetes_version" {
    default = "1.20.9"
  }

  variable "subnet_name" {
    description = "name to give the subnet"
    default     = "AKS-subnet"
  }


  variable "vnet_name" {
    description = "name of the vnet that this subnet will belong to"
    default = "AKS-vnet"
  }

  variable "subnet_cidr" {
    description = "the subnet Address range"
    default = "10.1.0.0/24"
  }

  variable "network_security_group_name" {
    description = "network security group name"
    default = "AKS-SG"
  }

  variable "pendpoint_cidr" {
    description = "private endpoint subnet cidr"
    default = "10.1.5.0/24"
  }

  variable "pendpoint_subnetname" {
    default = "PrivateEndpoint-Subnet"
  }

  variable "acr_name" {
  default = "demoupdatedacr"
  description = "ACR name"
}