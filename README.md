## Terraform GKE provisioning scripts description:

## GKE Cluster implemented with 2 nodes in the same zone (Single-Zone Cluster) to avoid resource quotas exceeding

#### [GKE-CLUSTER](gke-cluster.tf) - Cluster & Node pool declaration
#### [VPC](vpc.tf) - VPC & subnet declaration
#### [OUTPUTS](outputs.tf) - outputs declaration
#### [TERRAFORM VARIABLES](terraform.tfvars) - Variables needed to create/destroy cluster: project-id, region, zone