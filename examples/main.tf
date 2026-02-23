terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = "sujathapamuluri4b4"
}

resource "github_repository" "example" {
  name        = "tf-automation-repo"
  description = "Example repo created via Terraform"
  visibility  = "private"
  has_issues  = true
  has_wiki    = false
}
