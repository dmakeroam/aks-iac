data "azurerm_kubernetes_service_versions" "current" {
  location       = var.location
  version_prefix = 1.26
  include_preview = true
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${var.company}-${var.project}-${var.environment}-aks"
  location            = var.location
  resource_group_name = var.aks_resource_group_name
  dns_prefix          = "${var.company}-${var.project}-${var.environment}-aks"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name                  = "agentpool"
    os_sku                = "CBLMariner"
    vnet_subnet_id        = azurerm_subnet.aks_private_subnet.id
    vm_size               = var.aks_node_vm_size
    type                  = "VirtualMachineScaleSets"
    enable_node_public_ip = var.aks_node_enable_public_ip
    node_count            = var.aks_agent_node_count
    orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "azure"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.aks_admin_group_object_ids
    azure_rbac_enabled     = true
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "aks_node_user_pool" {
  name                  = var.aks_node_user_pool_name
  os_sku                = "CBLMariner"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vnet_subnet_id        = azurerm_subnet.aks_private_subnet.id
  mode                  = "User"
  vm_size               = var.aks_node_vm_size
  os_type               = "Linux"
  priority              = "Regular"
  enable_node_public_ip = var.aks_node_enable_public_ip
  zones                 = var.aks_node_availability_zones
  enable_auto_scaling   = var.aks_enable_auto_scaling
  node_count            = var.aks_node_count
  min_count             = var.aks_node_min
  max_count             = var.aks_node_max
  node_labels           = var.aks_node_labels
  orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
}