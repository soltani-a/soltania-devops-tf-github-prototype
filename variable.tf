variable "repositories" {
  description = "Map of GitHub repositories to provision"
  type = map(object({
    description = string
    visibility  = string
  }))
  default = {
    "default_repo" = {
      description = "Description par défaut du repository"
      visibility  = "private"
    }
  }
}