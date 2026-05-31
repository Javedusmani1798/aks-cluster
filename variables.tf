variable "resource_group_name" {
  description = "The name of the resource group in which to create the AKS cluster."
  type        = string
  default     = "rg-aks-secure"
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "aks-secure-cluster"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster."
  type        = string
  default     = "aks-secure"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster."
  type        = string
  default     = "1.30"
}

variable "vnet_address_space" {
  description = "The address space for the Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  description = "The address prefix for the AKS subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "node_count" {
  description = "The initial number of nodes in the default node pool."
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "The size of the Virtual Machines for the nodes."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "enable_azure_active_directory" {
  description = "Whether to enable Azure Active Directory integration."
  type        = bool
  default     = true
}

variable "admin_group_object_ids" {
  description = "A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
