data "azurerm_resource_group" "pipeops_rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "pipeops_subnet"{
  name = var.pipeops_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name = var.resource_group_name
}

module "aks" {
  source  = "Azure/aks/azurerm"
  version = "9.3.0"
  resource_group_name = data.azurerm_resource_group.pipeops_rg.name
  cluster_name = var.cluster_name
  client_id = var.client_id
  client_secret = var.client_secret
  kubernetes_version = var.kubernetes_version
  log_analytics_workspace_enabled = false
  rbac_aad = false
  prefix = var.cluster_name
  node_pools = {
    test = {
      name = var.node_pool_name
      node_count = var.node_count
      vm_size = var.vm_size
      enable_auto_scaling = true
      max_count = var.max_count
      os_disk_size_gb = 50
      vnet_subnet_id = data.azurerm_subnet.pipeops_subnet.id
      tags = {
        "Name" = "pipeops-nodegroup"
        "cluster-autoscaler-enabled" = "true"
        "cluster-autoscaler-name" = "${var.cluster_name}"
      }
    }
  }
  net_profile_service_cidr = "10.4.0.0/20"
  net_profile_dns_service_ip = "10.4.0.10"
  temporary_name_for_rotation = "pipeops"
  oidc_issuer_enabled = true
  os_disk_size_gb = 50
  vnet_subnet_id = data.azurerm_subnet.pipeops_subnet.id
  private_cluster_enabled = false


  tags = {
    "Name" = "Production"
    "cluster-autoscaler-enabled" = "true"
    "cluster-autoscaler-name" = "${var.cluster_name}"
  }
}