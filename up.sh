#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Exit immediately if a command exits with a non-zero status.
set -e

current_dir=$(pwd)
cd "$current_dir" || exit 1

# Pull the latest changes
echo -e "${YELLOW}Pulling latest changes from the repository...${NC}"
if ! git pull; then
    echo -e "${RED}Failed to pull from repository. Exiting.${NC}"
    exit 1
fi

while true; do
    echo ""
    echo -e "${YELLOW}Current repository status:${NC}"
    git status -s
    echo ""

    read -p "$(echo -e "${YELLOW}Do you want to create a new commit? [y/n] ${NC}")" create_commit
    if [[ "$create_commit" == "n" ]]; then
        break
    fi

    read -p "$(echo -e "${YELLOW}Stage all changes (a) or add files individually (i)? [a/i] ${NC}")" stage_choice

    if [[ "$stage_choice" != "i" ]]; then
        git add .
        echo -e "${GREEN}All unstaged files have been staged.${NC}"
    else
        echo -e "${YELLOW}Enter file paths to stage. Press [TAB] for autocompletion.${NC}"
        echo -e "${YELLOW}Press [Enter] on an empty line when you are finished.${NC}"
        # The '-e' flag enables readline, which allows for tab-completion of file paths.
        while read -e -p "File to add: " file_to_add; do
            if [[ -z "$file_to_add" ]]; then
                break
            fi
            if [[ -e "$file_to_add" ]]; then
                git add "$file_to_add"
                echo -e "${GREEN}Staged: $file_to_add${NC}"
            else
                echo -e "${RED}Error: File '$file_to_add' not found.${NC}"
            fi
        done
    fi

    echo ""
    echo -e "${YELLOW}Currently staged changes:${NC}"
    git diff --staged --name-status
    echo ""

    # Check if there are any changes staged for commit.
    if git diff --staged --quiet; then
        echo -e "${YELLOW}No changes are staged. Nothing to commit.${NC}"
        continue
    fi

    read -p "$(echo -e "${YELLOW}Use default commit message 'New commit'? [y/n] ${NC}")" use_default_msg
    if [[ "$use_default_msg" == "y" ]]; then
        commit_message="New commit"
    else
        read -p "$(echo -e "${YELLOW}Enter commit message: ${NC}")" commit_message
    fi

    if git commit -m "$commit_message"; then
        echo -e "${GREEN}Changes committed successfully.${NC}"
    else
        echo -e "${RED}Failed to commit changes.${NC}"
    fi
done

echo ""
# Check if there are local commits to push by comparing local HEAD with its upstream branch.
if git rev-parse @{u} > /dev/null 2>&1 && git log @{u}..HEAD > /dev/null 2>&1; then
    read -p "$(echo -e "${YELLOW}Do you want to push your commits to the remote repository? [y/n] ${NC}")" push_decision
    if [[ "$push_decision" != "n" ]]; then
        if git push; then
            echo -e "${GREEN}Commits pushed successfully.${NC}"
        else
            echo -e "${RED}Failed to push commits.${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}Commits were not pushed.${NC}"
    fi
else
    echo -e "${YELLOW}No local commits to push, or upstream branch not configured.${NC}"
fi

echo -e "${GREEN}Script finished.${NC}"