#service principle credentials
subscription_id = ""
client_id       = ""
client_secret   = ""
tenant_id       = ""

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
