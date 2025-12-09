#!/bin/bash

# ==============================================================================
# Terraform Automation Wrapper for Slim Soltani - Solutions Architect
# Description: Robust wrapper to init, plan, and apply infrastructure.
# Usage: ./scripts/tf_wrapper.sh [fmt|init|plan|apply|destroy]
# ==============================================================================

# 1. Strict Mode (Fail on error, undefined vars, or pipe failures)
set -euo pipefail

# 2. Constants and Path Definitions
# Uses absolute paths based on the script location to be directory-agnostic
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
# Adjust this path if your terraform files are in a different subfolder
TERRAFORM_DIR="$PROJECT_ROOT/src/main/terraform"
PLAN_FILE="tfplan.binary"

# Color Codes for improved readability
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 3. Utility Functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_dependencies() {
    if ! command -v terraform &> /dev/null; then
        log_error "Terraform is not installed or not in the PATH."
        exit 1
    fi
    
    # Optional: Check for critical environment variables (e.g., for GitHub Provider)
    if [ -z "${GITHUB_TOKEN:-}" ]; then
         log_warn "GITHUB_TOKEN variable is not set. Terraform might fail if the provider requires it."
    fi
}

usage() {
    echo "Usage: $0 {fmt|init|plan|apply|destroy}"
    echo "  fmt     : Format Terraform code recursively"
    echo "  init    : Initialize Terraform backend and providers"
    echo "  plan    : Generate an execution plan"
    echo "  apply   : Apply the generated plan (or auto-approve if no plan exists)"
    echo "  destroy : Destroy the infrastructure"
    exit 1
}

# 4. Main Execution Logic
main() {
    # Argument validation
    if [ $# -eq 0 ]; then
        usage
    fi
    
    COMMAND="$1"
    
    log_info "Starting Terraform Wrapper..."
    check_dependencies
    
    # Navigate to the Terraform directory
    if [ ! -d "$TERRAFORM_DIR" ]; then
        log_error "Terraform directory not found: $TERRAFORM_DIR"
        exit 1
    fi
    cd "$TERRAFORM_DIR"

    case "$COMMAND" in
        fmt)
            log_info "Formatting Terraform code..."
            terraform fmt -recursive
            log_success "Formatting complete."
            ;;
            
        init)
            log_info "Initializing backend and providers..."
            terraform init -upgrade
            log_success "Initialization complete."
            ;;
            
        plan)
            log_info "Generating execution plan..."
            # Check formatting before planning as a best practice
            terraform fmt -check || log_warn "Code is not formatted. Please run '$0 fmt'."
            
            terraform init -input=false
            terraform plan -out="$PLAN_FILE"
            
            log_success "Plan generated at: $TERRAFORM_DIR/$PLAN_FILE"
            log_info "To apply this plan, run: $0 apply"
            ;;
            
        apply)
            log_info "Applying infrastructure changes..."
            
            if [ -f "$PLAN_FILE" ]; then
                log_info "Applying existing plan file..."
                terraform apply "$PLAN_FILE"
                rm -f "$PLAN_FILE" # Cleanup sensitive plan file after use
            else
                log_warn "No plan file found. Running interactive apply..."
                terraform apply
            fi
            
            log_success "Deployment completed successfully!"
            ;;
            
        destroy)
            log_warn "WARNING: You are about to DESTROY the infrastructure."
            terraform destroy
            ;;
            
        *)
            log_error "Unknown command: $COMMAND"
            usage
            ;;
    esac
}

# Execute main function with arguments
main "$@"