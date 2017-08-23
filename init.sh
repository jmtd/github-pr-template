#!/bin/sh
set -u
set -e

# Users must run this after a fresh clone of this repository

git submodule update --init
git submodule foreach "
    if [ \"\$(git remote | wc -l)\" -lt 2 ]; then
        hub fork;
    fi"
