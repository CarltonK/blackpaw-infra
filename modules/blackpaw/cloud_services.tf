resource "google_project_service" "lengaqu-services" {
  count              = length(var.project_services)
  service            = var.project_services[count.index]
  provider           = google-beta
  disable_on_destroy = true
}
