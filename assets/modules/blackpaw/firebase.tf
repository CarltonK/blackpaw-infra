resource "google_firebase_project" "firebase_project" {
  project  = var.project_id
  provider = google-beta
}
