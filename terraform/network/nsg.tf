resource "azurerm_network_security_group" "nsg_admin" {
  name                = "nsg-subnet-admin"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH-From-Bastion"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "10.10.254.0/27" # subnet bastion
    destination_port_range     = "22"
    source_port_range          = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Internal-Monitoring"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "10.10.1.0/24" # subnet admin
    destination_port_range     = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-VNet-Inbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
  }

  # VLAN 20 (admin) peut accéder aux interfaces web (HTTP/HTTPS)
  security_rule {
    name                       = "Allow-VLAN20-HTTPS"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "192.168.200.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-VLAN20-HTTP"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "192.168.200.0/24"
    destination_address_prefix = "*"
  }
  security_rule {
  name                       = "Allow-TestSubnet"
  priority                   = 150
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "*"
  source_address_prefix      = "10.10.3.0/24" # subnet test
  destination_address_prefix = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  }
  security_rule {
  name                       = "Allow-Prometheus-1"
  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "9100"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Prometheus-2"
  priority                   = 205
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "9090"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Grafana"
  priority                   = 210
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "3000"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Teampass-Web"
  priority                   = 220
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

}

resource "azurerm_subnet_network_security_group_association" "admin_subnet_assoc" {
  subnet_id                 = azurerm_subnet.subnet_admin.id
  network_security_group_id = azurerm_network_security_group.nsg_admin.id
}

resource "azurerm_network_security_group" "nsg_users" {
  name                = "nsg-subnet-users"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH-From-Bastion"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "10.10.254.0/27"
    destination_port_range     = "22"
    source_port_range          = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-VNet-Inbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
  }

  # VLAN 10 (users) peut accéder uniquement à Nextcloud (HTTP/HTTPS)
  security_rule {
    name                       = "Allow-VLAN10-HTTPS"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "192.168.100.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-VLAN10-HTTP"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "192.168.100.0/24"
    destination_address_prefix = "*"
  }
  security_rule {
  name                       = "Allow-TestSubnet"
  priority                   = 150
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "*"
  source_address_prefix      = "10.10.3.0/24" # subnet test
  destination_address_prefix = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
}

}

resource "azurerm_subnet_network_security_group_association" "users_subnet_assoc" {
  subnet_id                 = azurerm_subnet.subnet_users.id
  network_security_group_id = azurerm_network_security_group.nsg_users.id
}

resource "azurerm_network_security_group" "nsg_test" {
  name                = "nsg-subnet-test"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-All-VNet"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "test_assoc" {
  subnet_id                 = azurerm_subnet.subnet_test.id
  network_security_group_id = azurerm_network_security_group.nsg_test.id
}
