terraform {
  required_version = ">= 1.3.0" # Nécessaire pour les fonctions modernes

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0" # Version récente requise pour les Rulesets
    }
  }
}

provider "github" {
  owner = "soltani-a"
  # Le token doit être dans la variable d'env GITHUB_TOKEN
  # Scopes requis : repo, read:org
}