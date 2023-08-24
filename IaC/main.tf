terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"

    }
  }
  
  backend "remote" {
    organization = "PrestonOrg"

    workspaces {
      name = "AutomatedEnvironment"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

  }

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  
  skip_provider_registration = true

  subscription_id = var.subscriptionid

}

locals {
  tags = {
    environment  = "prod"
    department   = "IT"
    contactemail = "${var.contactemail}"
  }
}

resource "azurerm_resource_group" "perftestgroup" {
  name     = "${var.projectnamingconvention}-rg"
  location = var.location

  tags = local.tags
}

resource "azurerm_storage_account" "appstorage" {
  name                     = lower(replace("${var.projectnamingconvention}sto", "-", ""))
  resource_group_name      = azurerm_resource_group.perftestgroup.name
  location                 = azurerm_resource_group.perftestgroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

//create azurerm_mssql_server
resource "azurerm_mssql_server" "sqlserver" {
  name                         = "${var.projectnamingconvention}-sql"
  resource_group_name          = azurerm_resource_group.perftestgroup.name
  location                     = azurerm_resource_group.perftestgroup.location
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
