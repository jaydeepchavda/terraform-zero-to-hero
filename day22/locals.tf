locals {
  bucket_perpose = {
    app = {
      perpose = "Application files"
    }
    logs = {
      perpose = "Aapplication logs"
    }
    backup = {
      perpose = "Database Backup"
    }
  }

  common_tags = {
    Company     = var.company
    Environment = var.environment
    project     = var.project
    ManagedBy   = "Terraform"
  }
}