# ==============================================================================
# TFLINT CONFIGURATION
# ==============================================================================

config {
  # Enables module inspection. Essential if you structure your code with modules.
  module = true
  
  # If true, returns a zero exit code even if issues are found (useful for CI/CD initially)
  force = false

  # Disables the strict checking of the TFLint version itself
  disabled_by_default = false
}

# ==============================================================================
# PLUGINS
# ==============================================================================

# The core Terraform plugin checks for syntax, deprecated features, and best practices.
plugin "terraform" {
  enabled = true
  preset  = "recommended" # Enables a standard set of rules defined by the community
}

# ==============================================================================
# SPECIFIC RULES (OVERRIDES)
# ==============================================================================

# Enforce descriptions on variables.
# This is crucial for terraform-docs to generate good documentation.
rule "terraform_documented_variables" {
  enabled = true
}

# Enforce descriptions on outputs.
rule "terraform_documented_outputs" {
  enabled = true
}

# Enforce explicit types for variables (e.g., string, list, map).
rule "terraform_typed_variables" {
  enabled = true
}

# Warn about unused declarations (variables defined but not used).
rule "terraform_unused_declarations" {
  enabled = true
}

# Ensure naming conventions (snake_case) are respected for resources and data sources.
rule "terraform_naming_convention" {
  enabled = true
}

# Require a specific Terraform version constraint in terraform {} block.
rule "terraform_required_version" {
  enabled = true
}

# Require a specific Provider version constraint in required_providers block.
rule "terraform_required_providers" {
  enabled = true
}