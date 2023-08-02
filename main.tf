# -----------------------------
# Terraform configuration
# -----------------------------

terraform {
  required_version = var.terraform_version
  required_providers {
    aws = {
      source  = "${var.aws_provider_source}"
      version = "${var.aws_provider_version}"
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
