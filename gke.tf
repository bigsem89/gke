resource "google_container_cluster" "cluster" {
  name = var.cluster_name
  project = var.project
  initial_node_count = var.initial_node_count
  enable_legacy_abac = var.enable_legacy_abac
  location = var.location

  node_config {
    machine_type = "n1-standard-1"
    //...
  }
}
