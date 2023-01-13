resource "google_compute_network" "gke-net" {
  name = "gke-net"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
}