variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "admin_password" {
  description = "Admin password for the Windows VM"
  sensitive   = true
}
