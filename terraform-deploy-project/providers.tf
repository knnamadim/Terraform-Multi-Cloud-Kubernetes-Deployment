variable "cloud_provider" {
  description = "Cloud provider to deploy resources (aws or gcp)"
  type        = string
  default     = "aws"
}

# AWS provider
provider "aws" {
  region = var.aws_region
  alias  = "aws"
  # Only load if selected
  count = var.cloud_provider == "aws" ? 1 : 0
}

# GCP provider
provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  alias   = "gcp"
  # Only load if selected
  count = var.cloud_provider == "gcp" ? 1 : 0
}
