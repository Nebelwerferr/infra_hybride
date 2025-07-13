terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.35.0"
    }
  }
}

provider "azurerm" {
  features {}


  subscription_id = "c11327dc-aef4-4bdb-b30f-61f6b55ced1e"
}


module "network" {
  source              = "./network"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vm_nextcloud" {
  source              = "./modules/vm_linux_simple"
  name                = "vm-nextcloud"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  subnet_id           = module.network.subnet_users_id
  public_ssh_key      = file("~/.ssh/id_rsa.pub")
}

module "vm_teampass" {
  source              = "./modules/vm_linux_simple"
  name                = "vm-teampass"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  subnet_id           = module.network.subnet_admin_id
  public_ssh_key      = file("~/.ssh/id_rsa.pub")
}

module "vm_supervision" {
  source              = "./modules/vm_linux_simple"
  name                = "vm-supervision"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  subnet_id           = module.network.subnet_admin_id
  public_ssh_key      = file("~/.ssh/id_rsa.pub")
}


module "vpn" {
  source              = "./vpn"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  vnet_name           = module.network.vnet_name
  subnet_gateway_id   = module.network.subnet_gateway_id
}

module "bastion" {
  source              = "./bastion"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  subnet_bastion_id   = module.network.subnet_bastion_id
}

module "vm_windows_test" {
  source              = "./modules/vm_windows_test"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_test_id
  admin_password      = var.windows_admin_password
}

