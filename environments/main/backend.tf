terraform {
  backend "gcs" {
    bucket = "<INFRA_PROJECT_ID>-tfstate"
    prefix = "environment/prod"
  }
}
