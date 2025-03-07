provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone_id
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  zone    = var.zone_id
}

###########
# MODULES #
###########

# module "blackpaw" {
#   source           = "../../assets/modules/blackpaw"
#   project_id       = var.project_id
#   region           = var.region
#   project_services = var.project_services
#   zone_id          = var.zone_id
#   ops_users        = var.ops_users
# }
