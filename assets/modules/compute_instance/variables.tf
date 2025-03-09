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
  default     = "debian-cloud/debian-12"
}

variable "machine_type" {
  type        = string
  description = "Compute Instance Machine Type"
  default     = "f1-micro"
}

variable "instance_tags" {
  type = list(string)
}

variable "startup_script" {
  description = "The startup script to be executed on the instance"
  default     = "echo 1"
}
