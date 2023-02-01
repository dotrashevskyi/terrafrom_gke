variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

variable "environment" {
  description = "environment"
}

variable "node_count" {
  default     = 2
  description = "number of gke nodes"
}