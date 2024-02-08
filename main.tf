resource "github_repository" "example" {
  name        = var.github_repository_name
  description = var.github_repository_description
  private     = var.github_repository_is_private
}