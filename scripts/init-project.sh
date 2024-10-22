#!/bin/bash

# Exit on any error
set -e

# Enable command printing for debugging
set -x

# Check if repository name was provided
if [ -z "$1" ]; then
    echo "Error: Please provide a repository name"
    echo "Usage: $0 <repository-name>"
    exit 1
fi

repo_name="$1"

echo "Working directory content:"
ls -la

# Configure Git
git config --global --add safe.directory /workspace
git config --global init.defaultBranch main
git config --global user.email "$(gh api user | jq -r .email)"
git config --global user.name "$(gh api user | jq -r .name)"

# Remove existing git if present
# rm -rf .git

# Initialize new repository
echo "Initializing new git repository..."
git init

# Add all files
echo "Adding files to git..."
git add .

# Initial commit
echo "Creating initial commit..."
git commit -m "Initial commit"

# Create GitHub repository and push
echo "Creating GitHub repository '$repo_name'..."
gh repo create "$repo_name" --public --source=. --push

echo "Successfully initialized and pushed repository to GitHub!"
