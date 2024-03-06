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

module "blackpaw" {
  source = "../../modules/blackpaw"
}
