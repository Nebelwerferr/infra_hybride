variable "location" {
  default = "France Central"
}
variable "resource_group_name" {
  default = "rg-hybride-infra"
}

variable "windows_admin_password" {
  description = "Admin password for Windows VM"
  sensitive   = true
}
