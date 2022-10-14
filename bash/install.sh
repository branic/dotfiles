#!/usr/bin/env bash

set -e

# Link the main vimrc file
ln -sf "${DOTFILES_LOCATION}/bash/.bashrc" "${HOME}/.bashrc"
