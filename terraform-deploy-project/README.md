# Terraform Multi-Cloud Kubernetes Deployment

This project provides a simple Terraform configuration to deploy a basic **Kubernetes cluster** on either **AWS EKS** or **GCP GKE**. You can switch between providers easily using a single variable.

---

## **Project Structure**
terraform-deplo-project/
├── main.tf                 #Core Terraform configuration (resources)
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── provider.tf             # Provider configuration (AWS or GCP)
├── terraform.tfvars        # Variable values
└── README.md               # Project documentation

----

## **Supported Providers**

- **AWS**: EKS cluster with IAM role (you can extend with VPC and node groups)
- **GCP**: GKE cluster with a node pool

---

## **Prerequisites**

- [Terraform](https://www.terraform.io/downloads) v1.5+ installed
- **AWS CLI** configured with proper credentials (for AWS)
- **GCP SDK** configured with proper credentials (for GCP)
- Access to create EKS/GKE clusters in your account/project

---

## **Usage**

1. **Clone the repository**
git clone <your-repo-url>
cd terraform-project

2. Configure terraform.tfvars: set cloud providers:
cloud_provider = "aws"   # "aws" or "gcp"
aws_region     = "us-east-1"
gcp_project    = "my-gcp-project-id"
gcp_region     = "us-central1"

3. Initialize Terraform:
terraform init

4. Preview the deployment:
terraform plan

5. Apply the deployment:
terraform apply

6. Outputs: 
AWS EKS endpoint: eks_cluster_endpoint
GCP GKE endpoint: gke_cluster_endpoint


Notes: to switch providers, change the **cloud_provider** value in **terraform.tfvars** and run:
terraform apply

You can add: 
- Add VPCs, subnets, and security groups for AWS EKS
- Add additional node pools or custom machine types for GCP GKE
- Configure kubeconfig output for easy kubectl access

-----

## Notes: in the main.tf, 
1. AWS EKS Dependencies: 

vpc_config {
  subnet_ids = aws_subnet.public[*].id
}

- aws_subnet.public is not defined in your current code. Terraform will fail unless you define subnets (or use an existing VPC/subnets).
- Same for the IAM role — aws_eks_cluster depends on the IAM role being created, so it’s fine, but make sure you actually create or reference VPC/subnets.

2. GCP GKE Node Pool:
cluster = google_container_cluster.gke_cluster[0].name

- Using [0] is correct when you have count on the cluster.
- Make sure the cluster exists (the count ensures it only exists if cloud_provider == "gcp").

