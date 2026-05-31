output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "kubernetes_cluster_name" {
  value = module.aks.aks_name
}

output "aks_id" {
  value = module.aks.aks_id
}
