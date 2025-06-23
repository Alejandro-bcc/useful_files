#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

current_dir=$(pwd)
cd "$current_dir" || exit 1

# Pull the latest changes
echo "Pulling latest changes from the repository..."
if ! git pull; then
    echo "Failed to pull from repository. Exiting."
    exit 1
fi

while true; do
    echo ""
    echo "Current repository status:"
    git status -s
    echo ""

    read -p "Do you want to create a new commit? [y/n] " create_commit
    if [[ "$create_commit" == "n" ]]; then
        break
    fi

    read -p "Stage all changes (a) or add files individually (i)? [a/i] " stage_choice

    if [[ "$stage_choice" != "i" ]]; then
        git add .
        echo "All unstaged files have been staged."
    else
        echo "Enter file paths to stage. Press [TAB] for autocompletion."
        echo "Press [Enter] on an empty line when you are finished."
        # The '-e' flag enables readline, which allows for tab-completion of file paths.
        while read -e -p "File to add: " file_to_add; do
            if [[ -z "$file_to_add" ]]; then
                break
            fi
            if [[ -e "$file_to_add" ]]; then
                git add "$file_to_add"
                echo "Staged: $file_to_add"
            else
                echo "Error: File '$file_to_add' not found."
            fi
        done
    fi

    echo ""
    echo "Currently staged changes:"
    git diff --staged --name-status
    echo ""

    # Check if there are any changes staged for commit.
    if git diff --staged --quiet; then
        echo "No changes are staged. Nothing to commit."
        continue
    fi

    read -p "Use default commit message 'New commit'? [y/n] " use_default_msg
    if [[ "$use_default_msg" == "y" ]]; then
        commit_message="New commit"
    else
        read -p "Enter commit message: " commit_message
    fi

    if git commit -m "$commit_message"; then
        echo "Changes committed successfully."
    else
        echo "Failed to commit changes."
    fi
done

echo ""
# Check if there are local commits to push by comparing local HEAD with its upstream branch.
if git rev-parse @{u} > /dev/null 2>&1 && git log @{u}..HEAD > /dev/null 2>&1; then
    read -p "Do you want to push your commits to the remote repository? [y/n] " push_decision
    if [[ "$push_decision" != "n" ]]; then
        if git push; then
            echo "Commits pushed successfully."
        else
            echo "Failed to push commits."
            exit 1
        fi
    else
		echo "Commits were not pushed."
    fi
else
    echo "No local commits to push, or upstream branch not configured."
fi

echo "Script finished."
