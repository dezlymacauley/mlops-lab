/*
  ABOUT: The provider block


*/
provider "github" {
  token = var.github_token
}

resource "github_repository" "production-repo" {
  name        = "production-repo"
  description = "repo for the production app"
  private     = true
}

