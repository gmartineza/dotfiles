#!/usr/bin/env bash

# Usage: ./push_all_git_repos.sh /path/to/parent-directory

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /path/to/parent-directory"
  exit 1
fi

BASE_DIR="$1"

# Find all directories containing a .git folder
find "$BASE_DIR" -type d -name ".git" | while read -r gitdir; do
  repo_dir="$(dirname "$gitdir")"
  echo "------------------------------"
  echo "Processing repository: $repo_dir"
  echo "------------------------------"

  cd "$repo_dir"

  # Show unstaged changes and untracked files
  changes=$(git status --short)

  if [ -z "$changes" ]; then
    echo "No changes detected."
  else
    echo "The following changes are untracked or modified:"
    echo "$changes"
    read -p "Do you want to stage ALL changes in this repository? Will run git add -A (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      git add -A
      echo "All changes staged."
    else
      echo "Skipping staging for this repo."
    fi
  fi

  # Check for staged changes to commit
  if ! git diff --cached --quiet; then
    echo "Committing staged changes..."
    git commit -m "Auto commit from push_all_git_repos.sh"
  else
    echo "No staged changes to commit."
  fi

 # Check if there is something to push
  if git status -uno | grep -q "Your branch is ahead"; then
    echo "Commits to be pushed:"

    # Get commit hashes ahead of upstream
    commits=$(git log --format="%H" @{u}..)

    for commit in $commits; do
      echo "----------------------------------------"
      echo "Commit: $commit"
      git show --compact-summary "$commit"
      echo "----------------------------------------"
    done

    echo
    echo "Pushing to remote..."
    git push
  else
    echo "Nothing to push."
  fi
done

