terraform {
    backend "s3" {
    bucket       = "jaydipaws-terraform-state-v1"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}