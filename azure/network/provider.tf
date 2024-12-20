
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
     prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = var.subscription_id
}

# Create a resource group
resource "azurerm_resource_group" "pipeops" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
