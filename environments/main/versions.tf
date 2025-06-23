terraform {
  required_version = "~> 1.8.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.40.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "6.40.0"
    }
  }
}
