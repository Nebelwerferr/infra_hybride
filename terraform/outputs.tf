output "bastion_url" {
  value = module.bastion.bastion_ip
}

output "vpn_gateway_ip" {
  value = module.vpn.vpn_gateway_public_ip
}

output "nextcloud_ip" {
  value = module.vm_nextcloud.private_ip
}

output "teampass_ip" {
  value = module.vm_teampass.private_ip
}

output "supervision_ip" {
  value = module.vm_supervision.private_ip
}

