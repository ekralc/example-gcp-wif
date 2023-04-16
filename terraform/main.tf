provider "google" {
  project = var.project_id
}

resource "google_project_service" "main" {
  // These are the APIs necessary to use WIF

  for_each = toset([
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com"
  ])

  service                    = each.key
  disable_dependent_services = true
}

resource "google_storage_bucket" "main" {
  name     = var.bucket_name
  location = "EU"
}

resource "google_storage_bucket_object" "main" {
  name         = "sample_file.txt"
  source       = "sample_file.txt"
  content_type = "text/plain"
  bucket       = google_storage_bucket.main.id
}

module "service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~> 3.0"

  project_id   = var.project_id
  names        = ["github-actions"]
  display_name = "GitHub Actions"
  description  = "Terraform managed account used by GitHub Actions pipelines"
  project_roles = [
    "${var.project_id}=>roles/storage.objectViewer",
  ]
}

module "gh_oidc" {
  source  = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version = "3.1.1"

  project_id  = var.project_id
  pool_id     = "github-wif-pool"
  provider_id = "github-wif"
  sa_mapping = {
    "github-actions" = {
      sa_name   = "projects/${var.project_id}/serviceAccounts/${module.service_account.email}"
      attribute = "attribute.repository/${var.github_repository}"
    }
  }

  depends_on = [
    google_project_service.main
  ]
}
