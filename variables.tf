variable "client_id" {
  description = "Azure Kubernetes Service Cluster service principal"
  default = "914494dc-51b8-4a65-9767-81b17999992d"
}

variable "client_secret" {
  description = "Azure Kubernetes Service Cluster password"
  default = "y-O8Q~uikZHVYBmxbh2OCXRVSAOqCRFu2BY2wdrq"
}

variable "resource_group_name" {
  description = "Resource Group name"
  default = "rg_aks"
}
variable "location" {
  description = ""
  default = "germanywestcentral"
}

variable "environment" {
  description = ""
  default = "Demo"
}

variable "aks_name" {
  description = "Azure Kubernetes Service Cluster name"
}

variable "node_count" {
  description = "Azure Kubernetes Service Cluster node count"
  default = 2
}

variable "vm_size" {
  description = "Azure Kubernetes Service Cluster virtual machine size"
  default = "Standard_B2s"
}

variable "os_disk_size_gb" {
  description = "Azure Kubernetes Service Cluster OS size in GB"
  default = 30
}
