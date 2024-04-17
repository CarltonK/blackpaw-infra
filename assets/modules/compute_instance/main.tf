# #######
# # GCE #
# #######
resource "google_compute_instance" "default_instance" {
  project      = var.project_id
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone_id

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  # metadata_startup_script = file("${path.module}/install_odoo.sh")

  tags = var.instance_tags

  network_interface {
    network = "default"
    access_config {}
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "echo '${file("${path.module}/install_odoo.sh")}' > /tmp/script.sh",
  #     "chmod +x /tmp/script.sh",
  #     "bash /tmp/script.sh"
  #   ]
  # }
}


# ############
# # FIREWALL #
# ############
resource "google_compute_firewall" "http_firewall" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8069"]
  }

  source_ranges = ["0.0.0.0/0"]
}
