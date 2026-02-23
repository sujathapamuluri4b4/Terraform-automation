variable "github_token" {
  description = "GitHub Personal Access Token with repo scope"
  type        = string
  sensitive   = true
}

variable "required_status_checks" {
  description = "List of required status check contexts for branch protection"
  type        = list(string)
  default     = ["ci/test", "ci/lint"]
}
