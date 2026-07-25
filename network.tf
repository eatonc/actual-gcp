resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false

  depends_on = [google_project_service.project]
}

resource "google_compute_subnetwork" "vpc_subnet" {
  # Matches the name GCP gives the auto-created subnet in an auto-mode VPC,
  # so existing deployments can `terraform import` this resource without a
  # forced rename (renaming a subnetwork forces replacement, which would
  # force-replace the instance's network_interface too).
  name          = google_compute_network.vpc_network.name
  ip_cidr_range = var.vpc_subnet_cidr
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.id
}