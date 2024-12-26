terraform {
  required_version = ">= 0.12"
}
variable subscription_id {
  type        = string
  description = "subscription id for azure service"
}

variable resource_group_name {
  type        = string
  description = "resource group name"
}

variable resource_group_location {
  type        = string
  description = "resource group location"
}

variable aks_cluster_name {
  type        = string
  description = "aks cluster name"
}

variable aks_dns_prefix {
  type        = string
  description = "aks dns prefix"
}

variable aks_node_count {
  type        = number
  description = "aks node count"
}

variable aks_vm_size {
  type        = string
  description = "aks vm size"
}

variable aks_identity_type {
  type        = string
  description = "aks identity type"
}

variable aks_tags {
  type        = map(string)
  description = "aks tags"
}


provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

   tags = var.aks_tags
}
