terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.95"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.resource_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name                = "agentpool"
    node_count          = 1
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 30
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version                = var.kubernetes_version
  role_based_access_control_enabled = var.enable_rbac

  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = var.load_balancer_sku
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  tags = var.cluster_tags
}

# Name of the Azure resource group
variable "resource_group_name" {
  default     = "aks-resource-group"
  description = "Name of the Azure resource group where the AKS cluster will be deployed."
}

# Name of the AKS cluster
variable "resource_name" {
  default     = "my-aks-cluster"
  description = "Name of the Azure Kubernetes Service (AKS) cluster."
}

# Azure region for resource deployment
variable "location" {
  default     = "eastus2"
  description = "Azure region where the resources will be deployed."
}

# DNS prefix for the AKS cluster
variable "dns_prefix" {
  default     = "myaksdns"
  description = "DNS prefix for the AKS cluster."
}

# Kubernetes version
variable "kubernetes_version" {
  default     = "1.30.7"
  description = "Version of Kubernetes to deploy in the cluster."
}

# Enable or disable RBAC
variable "enable_rbac" {
  default     = true
  description = "Boolean to enable or disable Role-Based Access Control (RBAC)."
}

# Network plugin
variable "network_plugin" {
  default     = "azure"
  description = "Network plugin to use for the AKS cluster. Options: azure, kubenet."
}

# Network plugin mode
variable "network_plugin_mode" {
  default     = "overlay"
  description = "Mode of the network plugin."
}

# Network dataplane
variable "network_dataplane" {
  default     = "azure"
  description = "The network dataplane used in the AKS cluster."
}

# Load balancer SKU
variable "load_balancer_sku" {
  default     = "standard"
  description = "Specifies the SKU of the load balancer used by the AKS cluster."
}

# Tags for the cluster
variable "cluster_tags" {
  default     = { environment = "dev", project = "aks-deployment" }
  description = "A map of tags to assign to the cluster."
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}
