output "repository_name" {
  description = "Name of the GitHub repository created"
  value       = github_repository.My_mini_proj.name
}

output "repository_url" {
  description = "URL of the GitHub repository"
  value       = github_repository.My_mini_proj.html_url
}

output "branch_name" {
  description = "Name of the branch created"
  value       = github_branch.Development.branch
}

# output "webhook_url" {
#   description = "Webhook URL configured for the repository"
#   value       = github_repository_webhook.terra-webhook.configuration[0].url
#   sensitive   = true  # Marking the output as sensitive
# }

output "webhook_events" {
  description = "Events that trigger the GitHub webhook"
  value       = github_repository_webhook.terra-webhook.events
}