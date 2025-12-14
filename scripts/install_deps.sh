#!/bin/bash

# ==============================================================================
# Dependency Installer for Terraform Wrapper
# Description: Installs TFLint and TFSec locally into the project (.bin folder).
# Usage: ./scripts/install_deps.sh
# ==============================================================================

set -euo pipefail

# --- PATH DEFINITIONS ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
LOCAL_BIN="${PROJECT_ROOT}/.bin"

# --- TOOL VERSIONS ---
# Update these versions as needed to get new features/fixes
TFLINT_VERSION="v0.50.3"
TFSEC_VERSION="v1.28.5"

# --- COLORS ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INSTALLER]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

# --- DETECT OS & ARCHITECTURE ---
get_os_arch() {
    OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
    ARCH="$(uname -m)"

    # Normalize architecture for GitHub releases naming conventions
    if [[ "$ARCH" == "x86_64" ]]; then
        ARCH="amd64"
    elif [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "arm64" ]]; then
        ARCH="arm64"
    fi

    echo "${OS}|${ARCH}"
}

# --- INSTALLATION LOGIC ---
install_tool() {
    local tool_name="$1"
    local version="$2"
    local url="$3"

    # Create local bin if it doesn't exist
    mkdir -p "$LOCAL_BIN"

    if [ -f "$LOCAL_BIN/$tool_name" ]; then
        # Optional: You could add version checking here, but skipping for speed
        return 0
    fi

    log_info "$tool_name not found. Installing $version..."

    if [[ "$url" == *".zip" ]]; then
        curl -L -s -o "/tmp/${tool_name}.zip" "$url"
        unzip -q -o "/tmp/${tool_name}.zip" -d "$LOCAL_BIN"
        rm "/tmp/${tool_name}.zip"
    else
        curl -L -s -o "$LOCAL_BIN/$tool_name" "$url"
    fi

    chmod +x "$LOCAL_BIN/$tool_name"
    log_success "$tool_name installed in $LOCAL_BIN"
}

# --- MAIN EXECUTION ---
OS_ARCH=$(get_os_arch)
OS_TYPE="${OS_ARCH%|*}"
ARCH_TYPE="${OS_ARCH#*|}"

# 1. Install TFLint
# URL Pattern: https://github.com/terraform-linters/tflint/releases/download/v0.50.3/tflint_linux_amd64.zip
TFLINT_URL="https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_${OS_TYPE}_${ARCH_TYPE}.zip"
install_tool "tflint" "$TFLINT_VERSION" "$TFLINT_URL"

# 2. Install TFSec
# URL Pattern: https://github.com/aquasecurity/tfsec/releases/download/v1.28.5/tfsec-linux-amd64
TFSEC_URL="https://github.com/aquasecurity/tfsec/releases/download/${TFSEC_VERSION}/tfsec-${OS_TYPE}-${ARCH_TYPE}"
install_tool "tfsec" "$TFSEC_VERSION" "$TFSEC_URL"