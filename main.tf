provider "google" {
  # Configuration options
}

terraform {
 backend "gcs" {
   bucket  = "bigsem89"
   prefix  = "terraform/state"
 }
}