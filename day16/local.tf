locals {

  bucket_purpose = {

    app = {
      purpose = "Application Files"
    }

    backup = {
      purpose = "Backup Storage"
    }

    logs = {
      purpose = "Log Storage"
    }

  }

  common_tags = {

    Company    = var.company
    Environment = var.environment
    Project     = var.project

  }

}