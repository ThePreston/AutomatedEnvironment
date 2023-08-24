
variable "location" {
  description = "Location of resource"
  type        = string
  default     = "East US"
}

variable "projectnamingconvention" {
  description = "Naming Convention"
  type        = string
  default     = ""
}

variable "contactemail" {
  description = "email of the contact resource"
  type        = string
  default     = ""
}

variable "subscriptionid" {
  description = "subscription id of the contact resource"
  type        = string
  default     = ""
}

variable "companyname" {
  description = "company name of the contact resource"
  type        = string
  default     = ""
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
