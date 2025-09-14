output "cluster_endpoint" {
  value = var.cloud_provider == "aws" ? aws_eks_cluster.eks_cluster[0].endpoint : google_container_cluster.gke_cluster[0].endpoint
  description = "The endpoint of the Kubernetes cluster (EKS or GKE)"
}
