# module "compute_instance" {
#   source       = "../compute_instance"
#   project_id   = var.project_id
#   name         = "blackpaw-community"
#   machine_type = "e2-standard-2"
#   instance_tags = [
#     "blackpaw",
#     "odoo",
#     "community"
#   ]
#   startup_script = file("../../assets/scripts/odoo_setup.sh")

#   depends_on = [google_project_service.blackpaw-services]
# }
