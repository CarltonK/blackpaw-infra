variable "project_id" {
  type        = string
  description = "Unique project identifier"
}

variable "region" {
  type        = string
  description = "Region containing assets"
}

variable "location" {
  description = "Multi-region name, options are: ASIA, EU, US"
  type        = string
}

variable "zone_id" {
  type        = string
  description = "Zone within region"
}

variable "workspace" {
  type        = string
  description = "Workspace"
}

variable "project_services" {
  type        = list(string)
  description = "Enabled project services"
}

variable "ops_users" {
  type        = list(string)
  description = "List of users with Ops permission set"
}

variable "ops_roles" {
  type        = list(string)
  description = "List of roles in Ops permission set"
}
