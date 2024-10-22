#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Please provide a commit message"
    exit 1
fi

# Configure git to trust the workspace directory
git config --global --add safe.directory /workspace
git config --global init.defaultBranch main
git config --global user.email "$(gh api user | jq -r .email)"
git config --global user.name "$(gh api user | jq -r .name)"


# Add all changes
git add -A

# Commit with provided message
git commit -m "$1"

# Push changes
git push

# Check if push was successful
if [ $? -eq 0 ]; then
    echo "Successfully added, committed, and pushed changes"
else
    echo "Error: Failed to push changes"
    exit 1
fi
