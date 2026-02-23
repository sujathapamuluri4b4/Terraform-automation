# NOTE: Teams are only supported in GitHub organizations, not personal accounts
# To use teams, create an organization and update the provider configuration
# For now, teams are commented out since this is a personal account

# resource "github_team" "devs" {
#   name        = "devs"
#   description = "Developers team"
#   privacy     = "closed"
# }
#
# resource "github_team_repository" "devs_repo" {
#   team_id    = github_team.devs.id
#   repository = github_repository.example.name
#   permission = "push"
# }
