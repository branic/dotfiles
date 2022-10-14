#!/usr/bin/env bash

set -e

# Link the main vimrc file
ln -sf "${DOTFILES_LOCATION}/vim/.vimrc" "${HOME}/.vimrc"

# Create the ftplugin directory and link language specific config files
mkdir -p "${HOME}/.vim/ftplugin"

for file in "${DOTFILES_LOCATION}"/vim/.vim/ftplugin/*; do
    ln -sf "${file}" "${HOME}/.vim/ftplugin/."
done
