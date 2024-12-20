
resource "azurerm_virtual_network" "pipeops_virtual_network" {
  name                = var.vnet_name
  location            = azurerm_resource_group.pipeops.location
  resource_group_name = azurerm_resource_group.pipeops.name
  address_space       = var.vpc_cidr
  dns_servers         = var.dns_servers_ip

  tags = {
    "Name"        = var.cluster_name
    "Environment" = "production"
    "Terraform"   = "true"
    "ManagedBy"   = "pipeops.io"

  }
}

resource "azurerm_subnet" "pipeops_subnet_1" {
  name = var.pipeops_subnet_1_name
  resource_group_name = azurerm_resource_group.pipeops.name
  virtual_network_name = azurerm_virtual_network.pipeops_virtual_network.name
  address_prefixes = var.pipeops_subnet_1_cidr
  depends_on = [ azurerm_virtual_network.pipeops_virtual_network ]
  
}

resource "azurerm_subnet" "pipeops_subnet_2" {
  name = var.pipeops_subnet_2_name
  resource_group_name = azurerm_resource_group.pipeops.name
  virtual_network_name = azurerm_virtual_network.pipeops_virtual_network.name
  address_prefixes = var.pipeops_subnet_2_cidr
  depends_on = [ azurerm_virtual_network.pipeops_virtual_network ]
}

resource "azurerm_subnet" "pipeops_subnet_3" {
  name = var.pipeops_subnet_3_name
  resource_group_name = azurerm_resource_group.pipeops.name
  virtual_network_name = azurerm_virtual_network.pipeops_virtual_network.name
  address_prefixes = var.pipeops_subnet_3_cidr
  default_outbound_access_enabled = false
  depends_on = [ azurerm_virtual_network.pipeops_virtual_network ]
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

resource "azurerm_subnet_nat_gateway_association" "example" {
  subnet_id      = azurerm_subnet.pipeops_subnet_3.id
  nat_gateway_id = azurerm_nat_gateway.pipeops_ng.id
  depends_on = [ azurerm_subnet.pipeops_subnet_3, azurerm_nat_gateway.pipeops_ng]
}