output "bastion_ip" {
  value = azurerm_public_ip.bastion_ip.ip_address
}
