#!/bin/bash

# Exit on any error
set -e

# Check if commit message was provided
if [ -z "$1" ]; then
    echo "Error: Please provide a commit message"
    echo "Usage: $0 <commit-message>"
    exit 1
fi

commit_message="$1"

# Configure Git silently
git config --global --add safe.directory /workspace >/dev/null 2>&1
git config --global init.defaultBranch main >/dev/null 2>&1
git config --global user.email "$(gh api user | jq -r .email)" >/dev/null 2>&1
git config --global user.name "$(gh api user | jq -r .name)" >/dev/null 2>&1

# Add all changes
git add -A

# Commit with provided message
git commit -m "$commit_message"

# Get current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Push to remote
git push origin "$current_branch"

echo "Changes committed and pushed successfully!"
