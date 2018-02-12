#!/bin/sh
set -u
set -e

# check to make sure we have all the image sources registered as git submodules

repo_prefix=git@github.com:jboss-container-images

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
        echo git submodule add "$repo_prefix/$repo.git" images/$repo
    fi
done
