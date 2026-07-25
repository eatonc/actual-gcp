terraform {
  cloud {

    organization = "your-organization"

    workspaces {
      name = "your-workspace"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.25"
    }
  }
}
