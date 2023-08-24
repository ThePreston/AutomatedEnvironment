
variable "location" {
  description = "Location of resource"
  type        = string
  default     = "East US"
}

variable "projectnamingconvention" {
  description = "Naming Convention"
  type        = string
  default     = "env-gen"
}

variable "contactemail" {
  description = "email of the contact resource"
  type        = string
  default     = ""
}

variable "companyname" {
  description = "company name of the contact resource"
  type        = string
  default     = "Microsoft"
}

variable "sqladminlogin" {
  description = "sql admin login"
  type        = string
  default     = ""
}

variable "sqladminloginpassword" {
  description = "sql admin password"
  type        = string
  default     = ""
}

variable "subscriptionid" {
  description = "subscription id of the contact resource"
  type        = string
}

variable "client_id" {
  description = "client id of the service principal"
  type        = string
}

variable "client_secret" {
  description = "client secret of the service principal"
  type        = string
}

variable "tenant_id" {
  description = "tenant id of the service principal"
  type        = string
}
