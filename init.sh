#!/bin/sh
set -u
set -e

# Users must run this after a fresh clone of this repository

git submodule init
git submodule update
git submodule foreach "hub fork"
