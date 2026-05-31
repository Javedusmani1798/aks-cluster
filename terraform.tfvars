resource_group_name           = "rg-aks-prod"
location                      = "East US"
cluster_name                  = "aks-prod-secure"
kubernetes_version            = "1.27"
node_count                    = 3
vm_size                       = "Standard_DS2_v2"
enable_azure_active_directory = true
admin_group_object_ids        = [] # Add your AAD Group Object IDs here

tags = {
  Environment = "Production"
  Project     = "AKS-Security-Project"
}
