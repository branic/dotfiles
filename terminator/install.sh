#!/usr/bin/env bash

set -e

# Create directories
mkdir -p "${HOME}/.config/terminator"


# Link the terminator config file
ln -sf "${DOTFILES_LOCATION}/terminator/config" "${HOME}/.config/terminator/config"
