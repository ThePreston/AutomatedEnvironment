
variable "projectnamingconvention" {
  description = "Naming Convention"
  type        = string
  default     = "autogenprojiac"
}

variable "location" {
  description = "Location of resource"
  type        = string
  default     = "East US"
}

variable "resourcegroup" {
  description = "Naming Convention"
  type        = string
  default     = "rg-Environment-Generator"
}

variable "sqladminlogin" {
  description = "sql admin login"
  type        = string
  default     = "sqladmin"
}

variable "sqladminloginpassword" {
  description = "sql admin password"
  type        = string
}
