#services principal credentials variables
variable "subscription_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "tenant_id" {
  type = string
}

#resource group variables
variable "RG_name" {
  type = string
}
variable "location" {
  type = string
}

#network variables
variable "vNet_NSG" {
  type = string
}

variable "network_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet1" {
  type = string
}

variable "subnet_address" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "linux_username" {
  type = string
}

variable "linux_password" {
  type = string
}