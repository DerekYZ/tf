#service principle credentials
subscription_id = "f6a7723b-56ed-4572-a4b2-0f147ad4fd1b"
client_id       = "269da7df-3cd4-4d4f-a67a-b8bdbf57e43c"
client_secret   = "02y7Q~FKCv2T79VM2j5h4w-cH44Eg5lJyd-Jw"
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
