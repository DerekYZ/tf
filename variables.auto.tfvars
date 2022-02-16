#service principle credentials
subscription_id = "f6a7723b-56ed-4572-a4b2-0f147ad4fd1b"
client_id       = "c77a6c19-f4e0-4a4c-9ab3-9ac50f602886"
client_secret   = "Cip7Q~Xa1mPKG7PKRwhSiZNmIyTU.aJeO2j31"
tenant_id       = "33da9f3f-4c1a-4640-8ce1-3f63024aea1d"

#resource group variables
RG_name  = "DerekZ_tf_rg"
location = "eastus"

#network variables
vNet_NSG       = "NSG_1"
network_name   = "vNet_1"
address_space  = ["10.0.0.0/16"]
subnet1        = "subnet1"
subnet_address = "10.0.1.0/24"

tags = { "Name" = "test" }