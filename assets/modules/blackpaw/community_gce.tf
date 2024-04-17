module "compute_instance" {
  source       = "../compute_instance"
  project_id   = var.project_id
  name         = "blackpaw-community"
  machine_type = "n1-standard-1"
  instance_tags = [
    "blackpaw",
    "odoo",
    "community"
  ]
  startup_script = file("${path.root}/assets/templates/odoo_setup.sh")

  depends_on = [google_project_service.blackpaw-services]
}
