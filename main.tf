data "azurerm_client_config" "current" {}

data "azurerm_subnet" "subnet_data"{
  name = var.subnet1
  virtual_network_name = azurerm_virtual_network.vNet.name
  resource_group_name = azurerm_resource_group.rg.name
}
output "subnet_info" {
  value = data.azurerm_subnet.subnet_data.id
}

#resource group
resource "azurerm_resource_group" "rg" {
  name     = var.RG_name
  location = var.location
}

#vnet
resource "azurerm_network_security_group" "my_NSG" {
  name                = var.vNet_NSG
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
    name                       = "allow_22"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "vNet" {
  name                = var.network_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space

  subnet {
    name           = var.subnet1
    address_prefix = var.subnet_address
    security_group = azurerm_network_security_group.my_NSG.id
  }
  tags = var.tags
}

resource "azurerm_public_ip" "linux1_PIP" {
  name                = "linux1_PIP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  name                = "${var.vNet_NSG}-${var.subnet1}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_data.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = azurerm_public_ip.linux1_PIP.id
  }
}

resource "azurerm_virtual_machine" "linux" {
  name                  = "${var.network_name}-${var.subnet1}-linux1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.linux_nic.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.network_name}-${var.subnet1}-linux1-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "azureuser"#azurerm_key_vault_secret.simple_scret_username.value
    admin_password = "Pa55w.rd"#azurerm_key_vault_secret.simple_scret_password.value
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.tags
}

# resource "azurerm_key_vault" "secrets" {
#   name                        = "DerekZkeyvault2"
#   location                    = azurerm_resource_group.rg.location
#   resource_group_name         = azurerm_resource_group.rg.name
#   enabled_for_disk_encryption = true
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = false

#   sku_name = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id
#     secret_permissions = [
#       "Get","Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set"
#     ]
#   }
#   access_policy {
#   tenant_id = data.azurerm_client_config.current.tenant_id
#   object_id = "3724c7b0-3b39-410d-aff9-82f21d9b5c3b"
#   secret_permissions = [
#     "Get","Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set"
#   ]
#   }
# }
# resource "azurerm_key_vault_secret" "simple_scret_username" {
#   name         = "username"
#   value        = var.linux_username
#   key_vault_id = azurerm_key_vault.secrets.id
# }
# resource "azurerm_key_vault_secret" "simple_scret_password" {
#   name         = "password"
#   value        = var.linux_password
#   key_vault_id = azurerm_key_vault.secrets.id
# }