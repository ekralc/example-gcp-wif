variable "project_id" {
  description = "A GCP project ID"
}

variable "github_repository" {
  description = "A repository URL on GitHub, e.g. ekralc/example_gcp_wif"
}

variable "bucket_name" {
  description = "The name of the GCS bucket to store the sample file"
}
