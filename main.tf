resource "azurerm_resource_group" "slotDemo" {
  name     = "exam1"
  location = "westus2"
}

resource "azurerm_app_service_plan" "slotDemo" {
  name                = "slotAppServicePlan"
  location            = azurerm_resource_group.slotDemo.location
  resource_group_name = azurerm_resource_group.slotDemo.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.slotDemo.name
  }

  byte_length = 9
}
resource "azurerm_app_service" "slotDemo" {
  name                = "slotAppService${random_id.randomId.hex}"
  location            = azurerm_resource_group.slotDemo.location
  resource_group_name = azurerm_resource_group.slotDemo.name
  app_service_plan_id = azurerm_app_service_plan.slotDemo.id
}

