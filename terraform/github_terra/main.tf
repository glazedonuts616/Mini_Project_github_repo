terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
provider "github" {
  token = var.github_token
}


resource "github_repository" "My_mini_proj" {
  name        = "My_mini_proj"
  description = "My new awesome mini project"

  visibility = "public"

}

resource "github_branch" "Development" {
  repository = github_repository.My_mini_proj.name
  branch = "Development"
}

resource "github_repository_webhook" "terra-webhook" {
  repository = github_repository.My_mini_proj.name
  events     = ["push", "pull_request"]
  configuration {
#   url          = "{var.webserver:5000}"
    url          = "http://172.232.206.158:5000"
    content_type = "json"
  }
}
