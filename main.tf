resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.cluster_name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.cluster_name}-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

module "aks" {
  source  = "Azure/aks/azurerm"
  version = "9.1.0"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix              = var.dns_prefix
  cluster_name        = var.cluster_name
  kubernetes_version  = var.kubernetes_version

  private_cluster_enabled         = true
  rbac_aad                        = var.enable_azure_active_directory
  rbac_aad_managed                = true
  rbac_aad_admin_group_object_ids = var.admin_group_object_ids
  rbac_aad_azure_rbac_enabled     = true

  vnet_subnet_id = azurerm_subnet.aks_subnet.id

  # Network profile
  network_plugin = "azure"
  network_policy = "azure"

  # Default node pool
  agents_count = var.node_count
  agents_size  = var.vm_size

  # Monitoring
  log_analytics_workspace_enabled = true
  log_analytics_workspace = {
    id   = azurerm_log_analytics_workspace.law.id
    name = azurerm_log_analytics_workspace.law.name
  }

  tags = var.tags
}
