output "repository_urls" {
  description = "URLs HTTP des dépôts gérés"
  value = {
    for name, repo in github_repository.repos : name => repo.html_url
  }
}