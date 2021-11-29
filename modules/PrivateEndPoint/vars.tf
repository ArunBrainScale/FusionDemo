variable "private_endpoint_name" {
  description = "Private Endpoint name"
}

variable "resource_group_name" {
  description = "Resource group name where private endpoint"
}

variable "private_connection_resource_id" {
  description = "Resource id of the private link service" 
}

variable "location" {
  description = "location"
}

variable "subnet_id" {
  description = "Resource ID for endpoint subnet"
}

variable "is_manual_connection" {
  description = "Manual approval is required if turned on"
  default     = false  
}

variable "subresource_name" {
  description = "subresource name which the Private Endpoint is able to connect to."
  type        = string
  default     = null
}

variable "request_message" {
  description = "Message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource."
  type        = string
  default     = null 
}

variable "private_dns_zone_group_name" {
  description = "Name of the Private DNS Zone Group"
  type        = string
}

variable "private_dns_zone_group_ids" {
  description = "List of Private DNS Zones to include within the private_dns_zone_group."
  type        = list(string)
}