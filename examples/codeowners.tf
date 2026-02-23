resource "github_repository_file" "codeowners" {
  repository     = github_repository.example.name
  file           = ".github/CODEOWNERS"
  content = <<-EOF
# CODEOWNERS example
* @sujathapamuluri4b4

# Docs owned by devs team
/docs/ @devs

# Source owned by devs team
/src/ @devs
EOF
  commit_message = "Add CODEOWNERS via Terraform"
}
