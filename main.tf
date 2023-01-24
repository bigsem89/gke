provider "google" {
  project = var.project
  region  = var.location
}
# Retrieve an access token as the Terraform runner
data "google_client_config" "provider" {}

provider "helm" {
  kubernetes {
    host  = "https://${google_container_cluster.cluster.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
    )
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
  }
  backend "gcs" {
    bucket = "bigsem89"
    prefix = "terraform/state"
  }
}