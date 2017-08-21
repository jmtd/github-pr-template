#!/bin/sh
set -u
set -e

# update the github pull request template for a single image
#
# This expects to be run from an image repository directory
# See "sync-all.sh" to execute this for every image source

# Hopefully the user has run init.sh which will have invoked hub and
# the credential will exist, but just in case...
if ! [ -f ~/.config/hub ]; then
    echo "You must run a 'hub' command and supply your username and password"
    echo "in order to generate ~/.config/hub"
    exit 1
fi

# GitHub PR template
template="../../PULL_REQUEST_TEMPLATE.md"
test -d .github || mkdir -p .github
cp "$template" .github/PULL_REQUEST_TEMPLATE.md
git add .github/PULL_REQUEST_TEMPLATE.md

# CONTRIBUTING.md (DCO instructions)
cp ../../CONTRIBUTING.md CONTRIBUTING.md
git add CONTRIBUTING.md

if git diff-index --quiet HEAD --; then
    # no changes
    exit 0
fi

github_user()
{
    awk  '/^- user: / { print $3 }' ~/.config/hub
}

# if we haven't got a remote matching the GH username then make one
# really this should have been done already by init.sh
if ! git remote | grep -q "$(github_user)"; then
    hub fork
fi

newbranch=update-pr-template-$RANDOM
git checkout -b "$newbranch"

git commit -F ../../commit_msg .github/PULL_REQUEST_TEMPLATE.md CONTRIBUTING.md
git push "$(github_user)" "$newbranch"
hub pull-request -F ../../commit_msg
