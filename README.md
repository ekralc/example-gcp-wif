# GCP Keyless Auth from GitHub Actions

This is an example of using Workload Identity Federation on GCP to authenticate a GitHub Actions Workflow.

Authenticating workflows should be an identity problem, not a secrets problem. So this shows how to achieve it with zero long-lived JSON keys!

Read more: https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions