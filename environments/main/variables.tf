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