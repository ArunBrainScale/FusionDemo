resource "azurerm_private_endpoint" "private_endpoint" {
  
  name = var.private_endpoint_name
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_id = var.subnet_id

  private_service_connection {
    name = "${var.private_endpoint_name}-connection"
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection = var.is_manual_connection
    subresource_names = [var.subresource_name]
    request_message = var.request_message
  }

  private_dns_zone_group {
    name = var.private_dns_zone_group_name
    private_dns_zone_ids = var.private_dns_zone_group_ids
  }

}