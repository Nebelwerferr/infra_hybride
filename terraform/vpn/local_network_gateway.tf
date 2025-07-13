resource "azurerm_local_network_gateway" "local_gw" {
  name                = "local-pfsense"
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = "88.124.239.194" 
  address_space = [
  "192.168.100.0/24",  # VLAN 10
  "192.168.200.0/24"   # VLAN 20
]

  tags = {
    environment = "hybride"
  }
}
