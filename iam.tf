resource "google_project_iam_binding" "container_admin" {
  project = var.project
  role    = "roles/container.admin"
  members = [
    "serviceAccount:${google_service_account.kubernetes.email}",
  ]
}
resource "google_project_iam_binding" "storage_admin" {
  project = var.project
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.kubernetes.email}",
  ]
}
resource "google_project_iam_binding" "compute_admin" {
  project = var.project
  role    = "roles/compute.admin"
  members = [
    "serviceAccount:${google_service_account.kubernetes.email}",
  ]
}
resource "google_project_iam_binding" "serviceusage_admin" {
  project = var.project
  role    = "roles/serviceusage.admin"
  members = [
    "serviceAccount:${google_service_account.kubernetes.email}",
  ]
}
resource "google_project_iam_binding" "iam_serviceAccountUser" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  members = [
    "serviceAccount:${google_service_account.kubernetes.email}",
  ]
}