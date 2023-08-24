terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"

    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

  }

  skip_provider_registration = true

}

locals {
  tags = {
    environment  = "prod"
    department   = "IT"
  }
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "${var.projectnamingconvention}-sql"
  resource_group_name          = var.resourcegroup
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sqladminlogin
  administrator_login_password = var.sqladminloginpassword
  tags                         = local.tags
}

//create sql database
resource "azurerm_mssql_database" "sqldb" {
  name                = "${var.projectnamingconvention}-sqldb"
  server_id           = azurerm_mssql_server.sqlserver.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  
  sku_name            = "Basic"
  tags                = local.tags
}
