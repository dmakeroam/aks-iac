# Project Config
company = "cloudnc"
project = "cloudnative"
environment = "develop"
location = "Southeast Asia"
# AKS Config
aks_resource_group_name = "cloudnc-cloudnative-develop-rg"
aks_node_availability_zones = ["1", "2"]
aks_node_enable_public_ip = false
aks_node_vm_size = "Standard_D4ads_v5"
kubernetes_version_prefix = 1.27
aks_admin_group_object_ids = ["d988a13c-0eb9-4b85-8aa0-792dd17797b5"]
# Network Config
vnet_address_space = "10.1.0.0/16"
private_subnet_address_space = "10.1.1.0/24"
public_subnet_address_space = "10.1.2.0/24"
# Agent Pool
aks_agent_node_count = 1
# Service Pool
aks_node_user_pool_name = "userservice"
aks_enable_auto_scaling = true
aks_node_count = 1
aks_node_min = 1 
aks_node_max = 3
aks_node_labels = {
  "pool":"service"
}