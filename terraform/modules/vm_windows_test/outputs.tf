output "windows_test_private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}
