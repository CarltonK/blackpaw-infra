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
