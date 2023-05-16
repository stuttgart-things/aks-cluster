# stuttgart-things/azure-vm

terraform module for creating virtual machines in azure

## Requirements and Dependencies:
- [Terraform](https://www.terraform.io/downloads.html) 1.3.9 or greater

## Requirements for terraform in Azure
```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login --use-device-code
az account show

# create service-principal for terraform w/ contributor role
az ad sp create-for-rbac --role="Contributor" \
--scopes="/subscriptions/<REPLACE-WITH-YOURS>"

#appId is the client_id defined above.
#password is the client_secret defined above.
#tenant is the tenant_id defined above.

# test login
az login --service-principal -u CLIENT_ID -p CLIENT_SECRET --tenant TENANT_ID
```
## Example to use this terraform module

The following is an example of *main.tf*.  Create the file and modify the variables with the desired values.

```
module "aks-cluster" {
    #source = "git::https://codehub.sva.de/Lab/stuttgart-things/kubernetes/aks-cluster.git"
    source = "../aks-cluster"
    
    client_id       = var.client_id
    client_secret   = var.client_secret
    
    resource_group_name = "rg_aks"
    location = "germanywestcentral"
    environment = "Demo" 

    aks_name = "aks-cluster"
    node_count = 2
    vm_size = "Standard_B2s"
    os_disk_size_gb = 30
}

resource "local_file" "kube_config" {
  content  = module.aks-cluster.kube_config
  filename = "${path.root}/kubeconfig"
}

```
The following is an example of *provider.tf*.  Create the file and modify the variables with the desired values.

```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.37.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
  }
  
  required_version = ">=1.3.7"
}

provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

}

```

The following is an example of *variables.tf*.  Create the file and modify the variables with the desired values.

```
 variable "client_id" {
  default     = false
  description = ""
}

variable "client_secret" {
  default     = false
  description = ""
}

variable "tenant_id" {
  default     =  false
  description = ""
}

variable "subscription_id" {
  default     = false
  description = ""
}

```
## Outputs
 - `kubeconfig` file - A file will be created with the k8s configuration


Run terraform init to download the module

```
terraform init \
-var="subscription_id=<REPLACE-WITH-YOURS>" \
-var="client_id=<REPLACE-WITH-YOURS>" \
-var="client_secret=<REPLACE-WITH-YOURS>" \
-var="tenant_id=<REPLACE-WITH-YOURS>"
```

Apply to create the tf ressources in azure

```
terraform plan \
-var="subscription_id=<REPLACE-WITH-YOURS>" \
-var="client_id=<REPLACE-WITH-YOURS>" \
-var="client_secret=<REPLACE-WITH-YOURS>" \
-var="tenant_id=<REPLACE-WITH-YOURS>"

terraform apply \
-var="subscription_id=<REPLACE-WITH-YOURS>" \
-var="client_id=<REPLACE-WITH-YOURS>" \
-var="client_secret=<REPLACE-WITH-YOURS>" \
-var="tenant_id=<REPLACE-WITH-YOURS>"
```

To delete the tf managed resources run destroy

```
terraform destroy \
-var="subscription_id=<REPLACE-WITH-YOURS>" \
-var="client_id=<REPLACE-WITH-YOURS>" \
-var="client_secret=<REPLACE-WITH-YOURS>" \
-var="tenant_id=<REPLACE-WITH-YOURS>"
```

## Version:
```
DATE           WHO              WHAT
2023-03-06     Ana C. Calva     AKS Cluster Module
```

Author Information
------------------

Ana C. Calva; 03/2023; SVA GmbH

