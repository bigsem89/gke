resource "google_container_cluster" "cluster" {
  name               = var.cluster_name
  initial_node_count = var.initial_node_count
  enable_legacy_abac = var.enable_legacy_abac
  location           = var.location
  remove_default_node_pool = true
  network = google_compute_network.gke-net.self_link
  subnetwork = google_compute_subnetwork.private.self_link
  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  node_config {
    machine_type = "n1-standard-1"
    //...
  }
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  release_channel {
    channel = "REGULAR"
  }
}
