resource "github_branch_protection" "main" {
  repository_id = github_repository.example.node_id
  pattern       = "main"
  enforce_admins = true

  required_status_checks {
    strict   = true
    contexts = var.required_status_checks
  }

  required_pull_request_reviews {
    dismiss_stale_reviews          = true
    require_code_owner_reviews     = true
    required_approving_review_count = 1
  }
}
