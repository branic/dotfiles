#!/usr/bin/env bash

set -e

# Create directories
mkdir -p "${HOME}/.config/powerline/"{colorschemes,themes}"/shell"


# Link the powerline config files
ln -sf "${DOTFILES_LOCATION}/powerline/config.json" "${HOME}/.config/powerline/config.json"
ln -sf "${DOTFILES_LOCATION}/powerline/colorschemes/shell/default.json" "${HOME}/.config/powerline/colorschemes/shell/default.json"
ln -sf "${DOTFILES_LOCATION}/powerline/themes/shell/brant.json" "${HOME}/.config/powerline/themes/shell/brant.json"
