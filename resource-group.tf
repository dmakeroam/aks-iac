resource "azurerm_resource_group" "aks_resource_group" {
  name     = "${var.company}-${var.project}-${var.environment}-rg"
  location = var.location
}