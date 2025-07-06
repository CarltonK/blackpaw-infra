resource "google_cloudbuild_trigger" "cloud_functions_build_trigger" {
  project     = var.project_id
  name        = "blackpaw-cloud-functions-builder"
  location    = var.region
  description = "Cloud build trigger for bclackpaw-admin repository"

  github {
    owner = "CarltonK"
    name  = "blackpaw-admin"
    push {
      branch = "main"
    }
  }

  substitutions = {
    _SERVICE_ACCOUNT = google_service_account.cloud_functions_sa.email
  }

  filename = "cloudbuild/deploy.yaml"

  service_account = data.google_service_account.build_service_account.id

  depends_on = [
    google_service_account.cloud_functions_sa
  ]
}
