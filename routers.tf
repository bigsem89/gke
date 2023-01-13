resource "google_compute_router" "router" {
  name    = "router"
  network = google_compute_network.gke-net.id
  region = var.location
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  router                             = google_compute_router.router.name
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  nat_ips = [google_compute_address.nat.self_link]
}

resource "google_compute_address" "nat" {
  name = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}