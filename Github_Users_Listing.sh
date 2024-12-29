#!/bin/bash

# Date: 28/12/2024
# Version: v1
# This script will output the users and collaboraters of that repo.
##################################

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# List users with read access to the repository
function list_users_with_read_access {
    curl -s -u "${USERNAME}:${TOKEN}" "${API_URL}/repos/${REPO_OWNER}/${REPO_NAME}/collaborators" | \
    jq -r '.[] | select(.permissions.pull) | .login' | \
    { read -r first || echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."; echo "$first"; }
}

# Main script
echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
list_users_with_read_access