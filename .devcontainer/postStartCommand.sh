#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

echo "Configuring git safe directory..."
git config --global --add safe.directory /workspace

echo "Installing dependencies using Poetry..."
poetry install

echo "Running environment validation script..."

source ./.devcontainer/env-validation.sh
echo "Starting environment checks..."
check_version python 3.12
check_version poetry
check_version pre-commit
check_files .env

# Print the final status
print_final_status

echo "Poststart success"
