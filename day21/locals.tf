locals {

  common_tags = {

    Company = var.company

    Environment = var.environment

    Project = var.project

    ManagedBy = "Terraform"

  }

}