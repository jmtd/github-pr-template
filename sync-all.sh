#!/bin/sh
set -u
set -e

echo WARNING: this script will potentially generate a LOT of Pull Requests across
echo a lot of repositories. Make sure that is REALLY what you want to do. Hit enter
echo to continue, otherwise kill this script now.
read confirm

git submodule update --remote --force --quiet
git submodule foreach --quiet ../../sync.sh
