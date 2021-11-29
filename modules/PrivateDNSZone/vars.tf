variable "private_dns_zone_name" {
    description = "Private DNS Zone name"
}

variable "resource_group_name" {
    description = "Resource name of private DNS zone"
}

variable "vnet_to_link" {
    description = "vnet id where the private link to create"
    type = string
}