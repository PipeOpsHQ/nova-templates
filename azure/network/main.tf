module "avm-res-network-virtualnetwork" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  address_space       = var.vpc_cidr
  name                = var.vnet_name
  location            = azurerm_resource_group.pipeops.location
  resource_group_name = azurerm_resource_group.pipeops.name
  subnets = {
    "subnet1" = {
      name             = "pipeops-subnet-1"
      address_prefixes = var.pipeops_subnet_1_cidr
      default_outbound_access_enabled = true
    }
    "subnet2" = {
      name             = "pipeops-subnet-2"
      address_prefixes = var.pipeops_subnet_2_cidr
      default_outbound_access_enabled = true
    }
    "subnet3" = {
      name             = "pipeops-subnet-3"
      address_prefixes = var.pipeops_subnet_3_cidr
      default_outbound_access_enabled = true
    }
    "subnet4" = {
      name             = "pipeops-subnet-4"
      address_prefixes = var.pipeops_subnet_4_cidr
      nat_gateway = {
        id = azurerm_nat_gateway.pipeops_ng.id
      }
    }
    "subnet5" = {
      name             = "pipeops-subnet-5"
      address_prefixes = var.pipeops_subnet_5_cidr
      nat_gateway = {
        id = azurerm_nat_gateway.pipeops_ng.id
      }
    }
    "subnet6" = {
      name             = "pipeops-subnet-6"
      address_prefixes = var.pipeops_subnet_6_cidr
      nat_gateway = {
        id = azurerm_nat_gateway.pipeops_ng.id
      }
    }
  }
  tags = {
    "Name"        = var.cluster_name
    "Environment" = "production"
    "Terraform"   = "true"
    "ManagedBy"   = "pipeops.io"

  }
}

resource "azurerm_public_ip" "nat_ip" {
  name                = "ng-ip"
  location            = azurerm_resource_group.pipeops.location
  resource_group_name = azurerm_resource_group.pipeops.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones                   = ["1"]
}

resource "azurerm_nat_gateway" "pipeops_ng" {
  name                    = "pipeops-nat-gateway"
  location                = azurerm_resource_group.pipeops.location
  resource_group_name     = azurerm_resource_group.pipeops.name
  sku_name                = "Standard"
  zones                   = ["1"]
}


resource "azurerm_nat_gateway_public_ip_association" "ng_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.pipeops_ng.id
  public_ip_address_id = azurerm_public_ip.nat_ip.id
}
