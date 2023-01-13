provider "google" {
  project = var.project
  region  = var.location
}

terraform {
  backend "gcs" {
    bucket = "bigsem89"
    prefix = "terraform/state"
  }
}