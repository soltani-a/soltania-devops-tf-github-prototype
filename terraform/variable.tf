variable "repositories" {
  description = "Configuration centralisée des repositories"

  type = map(object({
    description  = string
    topics       = list(string)
    homepage_url = optional(string)
    visibility   = optional(string)
    has_wiki     = optional(bool)
    has_projects = optional(bool)
  }))

  default = {
    # Repo 1 : Bruno
    "soltania-automated-tests-bruno" = {
      description = "🚀 Enterprise-grade API Testing Showcase using Bruno CLI. Features self-healing tests, dynamic data generation, and a fully automated CI/CD pipeline via GitHub Actions."
      topics      = ["api-testing", "automation", "bruno-cli", "ci-cd", "devops", "github-actions", "qa-engineering", "self-healing"]
      # Homepage URL supprimée pour coller à votre dernier plan, remettre si nécessaire
    }

    # Repo 2 : Prototype (Celui avec Wiki/Projets)
    "soltania-github-governance" = {
      description  = "Industrialized GitHub Organization management using Terraform & Bash automation. A blueprint for scalable Infrastructure as Code (IaC) governance and GitOps workflows."
      topics       = ["automation", "bash", "bash-scripting", "devops", "github", "github-api", "iac", "infrastructure-as-code", "platform-engineering", "terraform"]
      homepage_url = "https://www.linkedin.com/in/ssoltanid"
    }

    # Repo 3 : Workflows
    "soltania-platform-workflows" = {
      description  = "Centralized library of reusable GitHub Actions workflows designed to standardize CI/CD, Infrastructure as Code, and Security pipelines across diverse technology stacks."
      topics       = ["automation", "cicd", "developer-experience", "devops", "github-actions", "governance", "infrastructure-as-code", "platform-engineering", "reusable-workflows", "security-compliance"]
      homepage_url = "https://www.linkedin.com/in/ssoltanid/"
    }

    # Repo 4 : Gouvernance (.github)
    ".github" = {
      description  = "Dépôt de gouvernance globale (Community Health Files)"
      topics       = ["governance", "metadata", "standards"]
      homepage_url = "https://github.com/soltani-a"
    }

    # Repo 5 : Community Profile & Governance
    # This special repository (same name as the owner) hosts the public profile README
    # and acts as the central hub for organization-wide documentation.
    "soltani-a" = {
      description  = "👋 Welcome to Soltania Technology. Central hub for my Solutions Architect portfolio, certifications, and technical vision."
      topics       = ["profile", "portfolio", "solutions-architect", "platform-engineering", "personal-branding"]
      homepage_url = "https://www.soltania-technology.com" # Ou votre LinkedIn si le site n'est pas prêt
      visibility   = "public"
    }

    # Repo 6 : SecOps Vault (Configuration as Code)
    "soltania-vault-governance" = {
      description  = "🔐 SecOps Showcase: Configuration as Code for HashiCorp Vault. Manages Policies, AppRoles, and Secret Engines using Terraform with a variable-driven approach."
      topics       = ["vault", "secops", "terraform", "configuration-as-code", "security", "access-management", "identity-management"]
      visibility   = "public"
      homepage_url = "https://www.soltania-technology.com"
    }
  }
}