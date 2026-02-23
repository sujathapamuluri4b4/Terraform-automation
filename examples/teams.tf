resource "github_team" "devs" {
  name        = "devs"
  description = "Developers team"
  privacy     = "closed"
}

resource "github_team_repository" "devs_repo" {
  team_id    = github_team.devs.id
  repository = github_repository.example.name
  permission = "push"
}
