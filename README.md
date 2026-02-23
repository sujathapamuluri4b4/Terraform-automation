# Terraform GitHub Examples

This folder contains simple Terraform examples to automate GitHub tasks (creating repositories, etc.).

Important security note:
- Do NOT share your GitHub password or paste it into files. Use a Personal Access Token (PAT) with only the scopes you need.
- Never commit `terraform.tfvars` or tokens to git. Add them to your local `.gitignore` (already included).

Quick start

1. Create a GitHub Personal Access Token with `repo` scope (and `admin:repo_hook` if you plan to manage hooks).
2. Set the token locally (recommended):

```bash
export TF_VAR_github_token="<YOUR_TOKEN_HERE>"
```

3. Initialize and apply the example:

```bash
cd terraform-github-examples/examples
terraform init
terraform plan
terraform apply
```

How the example works

- `variables.tf` reads a sensitive `github_token` variable.
- Provider `github` uses that token and the provided `owner` to create resources.

Files

- `examples/main.tf` — provider + `github_repository` example
- `examples/variables.tf` — token variable (sensitive)
- `examples/outputs.tf` — sample output
- `.gitignore` — ignores Terraform state and var files

If you want, I can:
- Add more examples (teams, org repos, branch protection)
- Show how to use GitHub Actions with Terraform
- Demonstrate storing tokens in GitHub Secrets or HashiCorp Vault

Added examples

- `examples/branch_protection.tf` — branch protection for `main` with required PR reviews.
- `examples/teams.tf` — creates a `devs` team and grants it `push` permission to the example repo.
- `examples/terraform.tfvars.example` — sample `terraform.tfvars` (DO NOT commit; copy locally).
- `.github/workflows/terraform-plan.yml` — example GitHub Actions workflow that runs `terraform init` and `terraform plan` using a secret.

GitHub Actions notes

- Store your PAT in the repository or organization secrets as `TERRAFORM_GITHUB_TOKEN` (not in code).
- The workflow uses `TF_VAR_github_token` to pass the token into Terraform.

Security and credentials (IMPORTANT)

- Do NOT share your GitHub password here or in files. If you shared your password in this repo or chat, revoke it immediately and create a Personal Access Token (PAT) with only the scopes you need.
- Use a PAT (recommended) and keep it in a secret manager or GitHub Secrets. Example minimum scopes: `repo` (for repo creation) and `admin:repo_hook` if managing hooks. For org-level changes you'll need appropriate org permissions.
- Never commit `terraform.tfvars` or tokens; add them to `.gitignore` (already included).

Next steps I can do for you

- Add a full branch-protection + required status checks + CODEOWNERS example.
- Add an org-level example (teams + members) — this requires org-level PAT permissions.
- Walk through creating a PAT and configuring the Actions secret on your repo.

If you'd like me to continue, tell me which next step to implement and I will proceed.


CODEOWNERS and required status checks

- `examples/CODEOWNERS` — example CODEOWNERS file; copy this into the repository (place in `.github/CODEOWNERS` or at repo root) to assign ownership for paths.
- `examples/branch_protection.tf` now uses a configurable variable `required_status_checks` (see `examples/variables.tf`) so you can require specific CI checks before merging.

How to enable required status checks and CODEOWNERS in practice

1. Ensure your CI provides the status-check context names (e.g., `ci/test`, `ci/lint`).
2. Either export the variable locally:

```bash
export TF_VAR_required_status_checks='["ci/test","ci/lint"]'
export TF_VAR_github_token="<YOUR_PAT>"
```

or add the contexts to `terraform.tfvars` (do not commit) by copying `terraform.tfvars.example`.

3. Apply the Terraform changes; branch protection will require the listed checks and CODEOWNERS will assign reviewers automatically when present in the repository.

If you want, I can also add a `github_repository_file` resource that writes the `CODEOWNERS` into the created repository automatically (requires the PAT to have repo write access). Tell me if you want that automated.

Automating `CODEOWNERS` with Terraform

- The example now includes `examples/codeowners.tf` which uses `github_repository_file` to create `.github/CODEOWNERS` in the repository Terraform creates.
- This requires the PAT to have repo write access (not just `repo:status`) so Terraform can push the file. For org-level repos, org write permissions are required.
- If the repository branch does not yet exist, Terraform will create the file on the default branch. Ensure the default branch name matches your expectations (commonly `main`).

To apply this automation locally:

```bash
export TF_VAR_github_token="<YOUR_PAT_WITH_REPO_WRITE>"
cd terraform-github-examples/examples
terraform init
terraform apply
```

If you'd like, I can modify the workflow to create the file via Actions (separate flow) or add safeguards such as creating the file only if a branch exists. Want me to add either of those?
