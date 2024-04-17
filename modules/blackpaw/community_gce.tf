module "blackpaw" {
  source     = "../compute_instance"
  project_id = var.project_id
  name       = "blackpaw-community"
  zone_id    = var.zone_id
  instance_tags = [
    "blackpaw",
    "odoo",
    "community"
  ]
}
