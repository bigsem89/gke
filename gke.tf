resource "google_container_cluster" "cluster" {
  name                     = var.cluster_name
  initial_node_count       = var.initial_node_count
  enable_legacy_abac       = var.enable_legacy_abac
  location                 = "${var.location}-b"
  remove_default_node_pool = true
  network                  = google_compute_network.gke-net.id
  subnetwork               = google_compute_subnetwork.private.id
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"

  node_config {
    service_account = google_service_account.kubernetes.email
  }
  node_locations = [
    "${var.location}-c"
  ]
  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  release_channel {
    channel = "REGULAR"
  }
  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }
  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}
