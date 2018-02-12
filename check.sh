#!/bin/sh
set -u
set -e

# check to make sure we have all the image sources registered as git submodules

all_upstream_repos()
{
    curl -s https://api.github.com/orgs/jboss-container-images/repos |\
        jq .[].name |\
        tr -d \" |\
        grep -v "^github-pr-template$" # this repo! ignore.
}

repo_registered()
{
    repo="$1"
    grep -q "$repo.git$" .gitmodules
}

all_upstream_repos | while read repo; do
    if ! repo_registered "$repo"; then
        echo "$repo"
    fi
done
