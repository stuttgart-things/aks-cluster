resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.aks_name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "azure-k8s"

  default_node_pool {
    name            = "default"
    node_count      = var.node_count 
    vm_size         = var.vm_size 
    os_disk_size_gb = var.os_disk_size_gb
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  role_based_access_control_enabled = true

  tags = {
    environment = var.environment
  }
}
