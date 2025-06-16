# #######
# # GCE #
# #######
resource "google_compute_instance" "default_instance" {
  project      = var.project_id
  name         = var.name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  metadata_startup_script = var.startup_script

  tags = var.instance_tags

  network_interface {
    network = "default"
    access_config {}
  }
}
