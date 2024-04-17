variable "project_id" {
  type        = string
  description = "Unique project identifier"
}

variable "name" {
  type        = string
  description = "Compute Instance Identifier"
}

variable "image" {
  type        = string
  description = "Compute Instance Image Type"
  default     = "debian-cloud/debian-11"
}

variable "machine_type" {
  type        = string
  description = "Compute Instance Machine Type"
  default     = "f1-micro"
}

variable "zone_id" {
  type        = string
  description = "Zone within region"
}


variable "instance_tags" {
  type = list(string)
}
