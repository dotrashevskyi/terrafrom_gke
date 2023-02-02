
# Only to show knowledge in locals
locals {
  cluster_name  = "${var.project_id}-${var.environment}-gke"
  nod_pool_name = "pool-${var.project_id}-${var.environment}"
  machine_type  = "e2-medium"
  disk_size_gb  = 20
  disk_type     = "pd-balanced"
  tags          = ["gke-node", "${var.project_id}-${var.environment}-gke"]
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = local.cluster_name
  location = var.zone

  # Will use Separately Managed Node Pool
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    disk_size_gb = local.disk_size_gb
    disk_type    = local.disk_type
  }

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = local.nod_pool_name
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    machine_type = local.machine_type
    disk_size_gb = local.disk_size_gb
    disk_type    = local.disk_type
    tags         = local.tags
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
