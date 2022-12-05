# Create a resource Group
resources "azurerm_resources_group" "appservice-rg" {
  name      = "devops-demo-dev"
  location  = "East us"
  tags = {
    description = "Demo"
    environment = "PC"
    project     = "guru"
  }
}

# Create the App Service plan
resource "azurerm_app_service_plan" "service-plan" {
  name                = "Cloud_Web_app"
  location            = "East us"
  resource_group_name = "devops-demo-dev"
  kind                = "windows"
  
  sku {
    tier = "standard"
    size = "s1"
  }
  tags - {
    description = "demo"
    environment = "pc"
    project     = "guru"
  }
}

# Create the App Service
resource "azurerm_app_service" "app-service" {
  name                = "Cloud_Web_app"
  location            = "East us"
  resource_group_name = azurerm_resource_group.appservice-rg.name
  app_service_plan_id = azurm_app_service_plan.service-plan.id
  site_config {
    linux_fx_version ="DOTNETCORE|3.1"
  }

  tags = {
    description = "demo"
    environment = "pc"
    project     = "guru"
  }
}

#  Deploy code from a private GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_windows_web_app.webapp.id
  repo_url           = "https:https://github.com/reddyguru/dev-test.git"
  branch             = "main"
  use_manual_integration = true
  use_mercurial      = false
}