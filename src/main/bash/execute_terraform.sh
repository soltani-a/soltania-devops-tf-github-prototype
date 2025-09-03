#!/bin/bash

# Save current directory
START_DIR="$(pwd)"

# Get absolute paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
TERRAFORM_DIR="$PROJECT_ROOT/src/main/terraform"

# Timestamp for plan file
current_date=$(date +"%Y%m%d_%H%M%S")

echo "[INFO] Project root: $PROJECT_ROOT"
echo "[INFO] Terraform directory: $TERRAFORM_DIR"
cd "$TERRAFORM_DIR"

echo "[INFO] Formatting Terraform files..."
terraform fmt

echo "[INFO] Initializing Terraform..."
terraform init -input=false

echo "[INFO] Planning Terraform deployment..."
terraform plan -out="$current_date.tfplan" -input=false

echo "[INFO] Applying Terraform plan..."
terraform apply -auto-approve -input=false "$current_date.tfplan"

echo "[INFO] Archiving plan..."
mkdir -p old
mv "$current_date.tfplan" old/

# Return to starting directory
cd "$START_DIR"
echo "[SUCCESS] Deployment complete! Back to $START_DIR"