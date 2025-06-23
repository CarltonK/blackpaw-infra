resource "google_firebase_project" "firebase_project" {
  project  = var.project_id
  provider = google-beta
}

resource "google_firestore_database" "default" {
  project                     = var.project_id
  name                        = "(default)"
  location_id                 = var.location
  type                        = "FIRESTORE_NATIVE"
  concurrency_mode            = "OPTIMISTIC"
  app_engine_integration_mode = "DISABLED"

  depends_on = [
    google_firebase_project.firebase_project,
    google_project_service.blackpaw-services
  ]
}
