# -----------------------------
# Terraform configuration
# -----------------------------
terraform {
  required_version = ">=0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

# -----------------------------
# Provider
# -----------------------------
provider "aws" {
  profile = var.project
  region  = var.region
}
