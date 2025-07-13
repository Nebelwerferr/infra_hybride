output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "location" {
  value = azurerm_resource_group.main.location
}

output "subnet_users_id" {
  value = azurerm_subnet.subnet_users.id
}

output "subnet_bastion_id" {
  value = azurerm_subnet.subnet_bastion.id
}

output "subnet_gateway_id" {
  value = azurerm_subnet.subnet_gateway.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_admin_id" {
  value = azurerm_subnet.subnet_admin.id
}

#output "nat_gateway_ip" {
# value = azurerm_public_ip.nat_ip.ip_address
#}

output "subnet_test_id" {
  value = azurerm_subnet.subnet_test.id
}
