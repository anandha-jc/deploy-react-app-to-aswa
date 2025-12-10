variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "rg-my-first-react-app"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "uksouth"
}

variable "static_web_app_name" {
  description = "Name of the Azure Static Web App"
  type        = string
  default     = "swa-my-first-react-app"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "my-first-react-app"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}
