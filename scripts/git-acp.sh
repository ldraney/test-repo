#!/bin/bash

# Exit on any error
set -e

# Check if commit message was provided
if [ -z "$1" ]; then
    echo "Error: Please provide a commit message"
    echo "Usage: $0 <commit-message>"
    exit 1
fi

# Verify GH_TOKEN is available
if [ -z "$GH_TOKEN" ]; then
    echo "Error: GH_TOKEN environment variable is not set"
    exit 1
fi

commit_message="$1"

# Configure Git silently
git config --global --add safe.directory /workspace >/dev/null 2>&1
git config --global init.defaultBranch main >/dev/null 2>&1
git config --global user.email "$(gh api user | jq -r .email)" >/dev/null 2>&1
git config --global user.name "$(gh api user | jq -r .name)" >/dev/null 2>&1

# Configure git to use HTTPS with token
git config --global url."https://oauth2:${GH_TOKEN}@github.com/".insteadOf "https://github.com/"

# Add all changes
git add -A

# Commit with provided message
git commit -m "$commit_message"

# Get current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Push to remote (should now use token automatically)
git push origin "$current_branch"

echo "Changes committed and pushed successfully!"
