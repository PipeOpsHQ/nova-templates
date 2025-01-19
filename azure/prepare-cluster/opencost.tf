data "azurerm_subscription" "primary" {
}

resource "azurerm_role_definition" "opencost_role" {
  count  = var.install_opencost ? 1 : 0
  name        = "opencost-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is a custom role created for opencost"

  permissions {
    actions     = [
      "Microsoft.Compute/virtualMachines/vmSizes/read",
      "Microsoft.Resources/subscriptions/locations/read",
      "Microsoft.Resources/providers/read",
      "Microsoft.ContainerService/containerServices/read",
      "Microsoft.Commerce/RateCard/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}

module "opencost" {
  source = "./helm/opencost"
  count  = var.install_opencost ? 1 : 0
}

