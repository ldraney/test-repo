#!/bin/bash

# Exit on any error
set -e

# Enable command printing for debugging
# set -x

# Configure Git silently
git config --global --add safe.directory /workspace >/dev/null 2>&1
git config --global init.defaultBranch main >/dev/null 2>&1
git config --global user.email "$(gh api user | jq -r .email)" >/dev/null 2>&1
git config --global user.name "$(gh api user | jq -r .name)" >/dev/null 2>&1

# Just show the status
git status
