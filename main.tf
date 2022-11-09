terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.30.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "this" {
  name     = "project_one"
  location = "West Europe"
}

resource "azurerm_service_plan" "this" {
  name                = "service_project_one"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "F1" #Free to use!! 
}

resource "azurerm_linux_web_app" "this" {
  name                = "projectoneoziel"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_service_plan.this.location
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = false
    application_stack {
      docker_image     = "nginx"
      docker_image_tag = "latest"
    }
  }
}