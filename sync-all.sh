#!/bin/sh
set -u
set -e

git submodule update --remote --force
git submodule foreach --quiet '
    if echo "$name" | grep -q openshift; then
        ../../sync.sh;
    fi'
