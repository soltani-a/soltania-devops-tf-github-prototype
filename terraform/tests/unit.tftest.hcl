# Configuration of the mock provider to avoid creating real repos
mock_provider "github" {}

# Variables specific to the test
variables {
  repositories = {
    "test-repo-secure" = {
      description  = "Test repo"
      topics       = ["test"]
      homepage_url = ""
      visibility   = "private"
      has_wiki     = false
      has_projects = false
    }
  }
}

# Test block: Validate the logic without applying
run "validate_ruleset_enforcement" {
  command = plan

  # Check that Linear History is enforced for the private repo
  assert {
    condition     = github_repository_ruleset.main_strict["test-repo-secure"].rules[0].required_linear_history == true
    error_message = "Linear history must be enabled for all repositories."
  }

  # Check that Merge Commits are disabled (redundant check but good for safety)
  assert {
    condition     = github_repository.repos["test-repo-secure"].allow_merge_commit == false
    error_message = "Merge commits must be disabled in favor of squash/rebase."
  }
}