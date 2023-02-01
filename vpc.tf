# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/21" # 2048 addresses
  secondary_ip_range {
    ip_cidr_range = "10.10.8.0/21" # 1024 addresses -> 440 pods max for 4 nodes
    range_name    = "pods-addresses-range"
  }
  secondary_ip_range {
    ip_cidr_range = "10.10.16.0/25" # 126 addresses -> 100 services for example
    range_name    = "services-addresses-range"
  }
}