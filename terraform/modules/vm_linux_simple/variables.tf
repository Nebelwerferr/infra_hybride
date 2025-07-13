variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "public_ssh_key" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}
