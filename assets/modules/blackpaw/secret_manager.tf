resource "google_secret_manager_secret" "contabo_secret" {
  secret_id = "contabo"
  project   = var.project_id
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}
