#!/usr/bin/env bash

set -e

# See https://en.wikipedia.org/wiki/ANSI_escape_code
_YELLOW_FG="\e[38;5;226m"
_RESET="\e[0m"

if [ ! -f "${HOME}/.gitconfig-local" ]; then
    cp "${DOTFILES_LOCATION}/git/.gitconfig-local" "${HOME}/.gitconfig-local"

    if [[ $- == *i* ]]; then
        echo -n "Enter your full name: "
        read -re name
        sed -i "s/YOUR_NAME/${name}/" "${HOME}/.gitconfig-local"

        echo -n "Enter your email address: "
        read -re email
        sed -i "s/YOUR_EMAIL_ADDRESS/${email}/" "${HOME}/.gitconfig-local"

        echo -n "Enter your gpg signing key: "
        read -re gpgsign
        sed -i "s/YOUR_GPG_SIGNING/${gpgsign}/" "${HOME}/.gitconfig-local"
    else
        echo -e "${_YELLOW_FG}Update ~/.gitconfig-local with your username, email address, and git gpg signing key${_RESET}"
    fi
fi

# Link the main vimrc file
ln -sf "${DOTFILES_LOCATION}/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DOTFILES_LOCATION}/git/.gitignore-global" "${HOME}/.gitignore-global"
