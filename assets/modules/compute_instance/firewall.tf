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