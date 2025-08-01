terraform {
  required_version = "~> 1.12.2"

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
