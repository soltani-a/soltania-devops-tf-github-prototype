resource "github_repository" "example" {
  for_each = var.repositories

  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility
}