#! /usr/bin/env bash

set -e

if [ -d "${HOME}/.oh-my-zsh" ]; then
    echo "oh-my-zsh is already installed"
else
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1
fi

ln -sf "${DOTFILES_LOCATION}/omz/aliases.zsh" "${HOME}/.oh-my-zsh/custom/aliases.zsh"
ln -sf "${DOTFILES_LOCATION}/omz/exports.zsh" "${HOME}/.oh-my-zsh/custom/exports.zsh"
ln -sf "${DOTFILES_LOCATION}/omz/functions.zsh" "${HOME}/.oh-my-zsh/custom/functions.zsh"
