resource "azurerm_public_ip" "vpn_pip" {
  name                = "vpn-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
}

resource "azurerm_virtual_network_gateway" "vpn_gw" {
  name                = "vpn-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "VpnGw1"

  ip_configuration {
    name                          = "vpn-ipconfig"
    public_ip_address_id          = azurerm_public_ip.vpn_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_gateway_id
  }
}

resource "azurerm_virtual_network_gateway_connection" "vpn_connection" {
  name                         = "vpn-to-pfsense"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  type                         = "IPsec"
  virtual_network_gateway_id   = azurerm_virtual_network_gateway.vpn_gw.id
  local_network_gateway_id     = azurerm_local_network_gateway.local_gw.id
  shared_key                   = "SuperSecretVPNKey123!"

    ipsec_policy {
    dh_group         = "DHGroup14"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "AES256"
    ipsec_integrity  = "SHA256"
    pfs_group        = "PFS14"
    sa_lifetime      = 3600
  }

}
