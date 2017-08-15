#!/bin/sh
set -u
set -e

git submodule update --remote --force
git submodule foreach "../../sync.sh"
