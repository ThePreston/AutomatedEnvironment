terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"

    }
  }
}

terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

  }


/*
Deprecated
  skip_provider_registration = true

*/
  
}

locals {
  tags = {
    environment  = "prod"
    department   = "IT"
  }
}

resource "azurerm_resource_group" "generatedrg" {
  name     = "${var.projectnamingconvention}-rg"
  location = var.location

  tags = local.tags
}

resource "azurerm_storage_account" "appstorage" {
  name                     = lower(replace("${var.projectnamingconvention}sto", "-", ""))
  resource_group_name      = azurerm_resource_group.generatedrg.name
  location                 = azurerm_resource_group.generatedrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "${var.projectnamingconvention}-sql"
  resource_group_name          = azurerm_resource_group.generatedrg.name
  location                     = azurerm_resource_group.generatedrg.location
  version                      = "12.0"
  administrator_login          = var.sqladminlogin
  administrator_login_password = var.sqladminloginpassword
  tags                         = local.tags
}

resource "azurerm_mssql_database" "sqldb" {
  name                = "${var.projectnamingconvention}-sqldb"
  server_id           = azurerm_mssql_server.sqlserver.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  
  sku_name            = "Basic"
  
  tags                = local.tags

  depends_on = [ azurerm_mssql_server.sqlserver ]

}
