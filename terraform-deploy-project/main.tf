# AWS EKS 
resource "aws_eks_cluster" "eks_cluster" {
  count    = var.cloud_provider == "aws" ? 1 : 0
  name     = "example-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }
}

resource "aws_iam_role" "eks_role" {
  count = var.cloud_provider == "aws" ? 1 : 0
  name = "eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })
}

# GCP GKE 
resource "google_container_cluster" "gke_cluster" {
  count    = var.cloud_provider == "gcp" ? 1 : 0
  name     = "example-gke-cluster"
  location = var.gcp_region

  remove_default_node_pool = true
  initial_node_count       = 1
  network    = "default"
  subnetwork = "default"
}

resource "google_container_node_pool" "gke_nodes" {
  count    = var.cloud_provider == "gcp" ? 1 : 0
  name       = "example-node-pool"
  cluster    = google_container_cluster.gke_cluster[0].name
  location   = var.gcp_region
  node_count = 1

  node_config {
    machine_type = "e2-medium"
  }
}


