#!/usr/bin/env bash

set -e

DOTFILES_LOCATION=$(pwd)
export DOTFILES_LOCATION

# Install configurations
# Example: ./bin/dotfiles install <config type>

./bin/dotfiles install vim
