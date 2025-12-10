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
    "soltania-devops-tf-functional-test-bruno" = {
      description = "🚀 Enterprise-grade API Testing Showcase using Bruno CLI. Features self-healing tests, dynamic data generation, and a fully automated CI/CD pipeline via GitHub Actions."
      topics      = ["api-testing", "automation", "bruno-cli", "ci-cd", "devops", "github-actions", "qa-engineering", "self-healing"]
      # Homepage URL supprimée pour coller à votre dernier plan, remettre si nécessaire
    }

    # Repo 2 : Prototype (Celui avec Wiki/Projets)
    "soltania-devops-tf-github-prototype" = {
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
  }
}