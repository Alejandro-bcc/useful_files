#!/bin/bash

current_dir=$(pwd)
cd "$current_dir" || exit 1

# Pull the latest changes
if ! git pull; then
    echo "Failed to pull from repository. Exiting."
    exit 1
fi

# Stage all changes
git add .

# Get commit message from user
read -p "Would you like to use 'Files' as the commit message? [y/n] " decision

if [ "$decision" = "n" ]; then
    read -p "Insert commit message: " commit
else
    commit="Files"
fi

# Commit changes
if ! git commit -m "$commit"; then
    echo "Failed to commit changes. Exiting."
    exit 1
fi

# Push to the repository
if ! git push; then
    echo "Failed to push to repository. Exiting."
    exit 1
fi

echo "Changes pushed successfully."

