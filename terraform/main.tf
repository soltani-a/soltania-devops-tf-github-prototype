# ==============================================================================
# 1. GESTION DES REPOSITORIES
# ==============================================================================
resource "github_repository" "repos" {
  for_each = var.repositories

  name         = each.key
  description  = each.value.description
  topics       = each.value.topics
  homepage_url = each.value.homepage_url
  visibility   = coalesce(each.value.visibility, "public")

  # --- Features ---
  has_issues   = true
  has_wiki     = coalesce(each.value.has_wiki, false)
  has_projects = coalesce(each.value.has_projects, false)
  auto_init    = true

  # --- Stratégie de Merge (Adaptée à l'Histoire Linéaire) ---
  # IMPORTANT : On désactive le Merge Commit car votre Ruleset exige "Linear History"
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  # --- Sécurité de base ---
  vulnerability_alerts = true

  security_and_analysis {
    secret_scanning {
      status = coalesce(each.value.visibility, "public") == "public" ? "enabled" : "disabled"
    }
    secret_scanning_push_protection {
      status = coalesce(each.value.visibility, "public") == "public" ? "enabled" : "disabled"
    }
  }
}

# ==============================================================================
# 2. GOUVERNANCE & SÉCURITÉ (RULESETS MODERNES) - CORRIGÉ
# ==============================================================================
resource "github_repository_ruleset" "main_strict" {
  for_each = var.repositories

  name = "Gouvernance Stricte (Main)"

  # CORRECTION 1 : Le provider veut le NOM du repo, pas l'ID
  repository = github_repository.repos[each.key].name

  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  bypass_actors {
    actor_id    = 5                # L'ID 5 correspond au rôle interne "Maintain" (Admin) chez GitHub
    actor_type  = "RepositoryRole" # On cible un Rôle, pas une Application spécifique
    bypass_mode = "always"
  }

  rules {
    creation = true
    update   = true
    deletion = true

    required_linear_history = true
    required_signatures     = true

    # CORRECTION 2 : Le bloc s'appelle "pull_request", pas "required_pull_request"
    pull_request {
      required_approving_review_count = 1
      dismiss_stale_reviews_on_push   = true
      require_last_push_approval      = true # "require_last_update_approved" s'appelle ainsi ici
    }
  }
}

# ==============================================================================
# 3. GESTION DES FICHIERS (DRY)
# ==============================================================================

# A. Fichiers Communautaires (Uniquement dans le repo .github)
locals {
  has_dot_github = contains(keys(var.repositories), ".github")
}

resource "github_repository_file" "community_files" {
  # Liste des fichiers à injecter dans le repo .github
  for_each = local.has_dot_github ? toset([
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "SECURITY.md",
    "VERSIONING.md"
  ]) : []

  repository          = ".github"
  branch              = "main"
  file                = "profile/${each.key}" # GitHub cherche dans le dossier profile/ ou à la racine
  content             = file("${path.module}/templates/${each.key}")
  commit_message      = "Governance: Update ${each.key}"
  overwrite_on_create = true

  # Dépendance explicite pour éviter les erreurs 404/409 à la création du repo
  depends_on = [github_repository.repos]
}

# B. Licence (Injectée physiquement dans TOUS les repos)
resource "github_repository_file" "license" {
  for_each = var.repositories

  repository          = github_repository.repos[each.key].name
  branch              = "main"
  file                = "LICENSE"
  content             = file("${path.module}/templates/LICENSE")
  commit_message      = "Legal: Standardize License"
  overwrite_on_create = true

  depends_on = [github_repository.repos]
}