local = {
  bucket_purpose = {
    app = {
      purpose = "Application files"
    },
    backup = {
      purpose = "backup storage"
    },
    logs = {
      purpose = "logs storage"
    }
  }

  common_tags = {
    Compony = var.company
    Environement  = var.environment
    Project = var.project
  }

}

# -_{""