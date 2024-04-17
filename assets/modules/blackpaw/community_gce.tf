module "compute_instance" {
  source       = "../compute_instance"
  project_id   = var.project_id
  name         = "blackpaw-community"
  machine_type = "n1-standard-1"
  zone_id      = var.zone_id
  instance_tags = [
    "blackpaw",
    "odoo",
    "community"
  ]

  depends_on = [google_project_service.blackpaw-services]
}
