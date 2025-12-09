terraform {
  required_version = "~> 1.14.1"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.54.0"
    }
  }

  # Backend configuration for storing Terraform state
  # Uncomment and configure when ready to use remote state
  # backend "azurerm" {
  #   resource_group_name  = "tfstate-rg"
  #   storage_account_name = "tfstate<unique-id>"
  #   container_name       = "tfstate"
  #   key                  = "react-app.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
  
  # Use environment variables or Azure CLI authentication
  # Ensure you have set:
  # - ARM_CLIENT_ID
  # - ARM_CLIENT_SECRET
  # - ARM_SUBSCRIPTION_ID
  # - ARM_TENANT_ID
}
