# GCP Keyless Auth from GitHub Actions

This is an example of using Workload Identity Federation on GCP to authenticate a GitHub Actions Workflow.

Authenticating workflows should be an identity problem, not a secrets problem. So this shows how to achieve it with zero long-lived JSON keys!

Read more: https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions

# Usage

An example root Terraform module is in `terraform/`, this contains all the blocks required to authenticate workflows to a GCP project.

To run the `main.yml` workflow in your own repository, you'll need to set up the `PROVIDER_NAME` and `SA_EMAIL` secrets on GitHub. You can find their values in the Terraform outputs.

The example workflow proves the authentication works by listing the contents of a storage bucket.