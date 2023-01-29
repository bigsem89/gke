resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
  display_name = "Service Account For Terraform To Make GKE Cluster"
}

resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.cluster.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    labels = {
      role = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

  }
  autoscaling {
    max_node_count = 10
    min_node_count = 2
  }
}

resource "google_container_node_pool" "spot" {
  name       = "spot"
  cluster    = google_container_cluster.cluster.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }
  autoscaling {
    max_node_count = 10
    min_node_count = 0
  }
  node_config {
    preemptible  = true
    machine_type = "e2-small"
    labels = {
      role = "devops"
    }
    taint {
      effect = "NO_SCHEDULE"
      key    = "instance_type"
      value  = "SPOT"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}