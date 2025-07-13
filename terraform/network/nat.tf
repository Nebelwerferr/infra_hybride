#resource "azurerm_public_ip" "nat_ip" {
#  name                = "nat-ip"
#  location            = var.location
#  resource_group_name = var.resource_group_name
#  allocation_method   = "Static"
#  sku                 = "Standard"
#}

#resource "azurerm_nat_gateway" "nat" {
#  name                = "nat-gateway"
#  location            = var.location
#  resource_group_name = var.resource_group_name
#  sku_name            = "Standard"

#  public_ip_address_id = azurerm_public_ip.nat_ip.id
#}





#resource "azurerm_subnet_nat_gateway_association" "users_nat_assoc" {
#  subnet_id      = azurerm_subnet.subnet_users.id
#  nat_gateway_id = azurerm_nat_gateway.nat.id
#}

#resource "azurerm_subnet_nat_gateway_association" "admin_nat_assoc" {
#  subnet_id      = azurerm_subnet.subnet_admin.id
#  nat_gateway_id = azurerm_nat_gateway.nat.id
#}
