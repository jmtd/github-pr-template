#!/bin/sh
set -u
set -e

git submodule update --remote --force --quiet
git submodule foreach --quiet ../../sync.sh
