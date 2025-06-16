variable "project_id" {
  type        = string
  description = "Unique project identifier"
}

variable "region" {
  type        = string
  description = "Region containing assets"
}

variable "project_services" {
  type        = list(string)
  description = "Enabled project services"
}

variable "zone_id" {
  type        = string
  description = "Zone within region"
}

variable "operator_custom_role_permissions" {
  type = list(string)
  default = [
    // Compute Admin

  ]
  description = "Defines permission set of custom operator role"
}

variable "ops_users" {
  type        = list(string)
  description = "List of users with Ops permission set"
}

variable "ops_roles" {
  type        = list(string)
  description = "List of roles in Ops permission set"
  default = [
    "roles/compute.admin"
  ]
}
