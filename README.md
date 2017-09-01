# xPaas Pull Request template

This is a Pull Request Template for the [xPaas image
repositories](https://github.com/jboss-container-images).

This repository contains the template and some scripts for synchronising
the instances of the template in the image repositories with this master
copy.

## Pre-requisites

### `hub`

Available from https://hub.github.com/ or `brew install hub` on a Mac.

These scripts call `hub` via the name `hub` so you do not need to install
it as an alias for `git`.

## Usage

WARNING! These scripts open up Pull Requests for all submodules, that is
currently 27 other repositories. Please make sure that's exactly what you
want to do before running them!

### Getting started

To initialise the git submodules and set up the GitHub forks, run the `init.sh`
command. If you have not used `hub` already then you may be prompted for your
github username and password (and possibly 2FA token). This should only happen
once, after which an OAuth token is cached. Example:

    $ ./init.sh
    ...
    github.com username: jmtd
    github.com password for jmtd (never stored):
    two-factor authentication code: 422560

### Syncing/updating the image repositories

    $ ./sync-all.sh

#### Syncing/updating an individual repository

    cd images/<example image submodule>
    ../../sync.sh

## Caveats

When the default branch for one of the image repositories is changed, the submodule
definitions in this repository will need to be manually updated.
