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
        
        if [[ -n "${name}" ]]; then
            sed -i -e '/name = /s|# ||' -e "s/YOUR_NAME/${name}/" "${HOME}/.gitconfig-local"
        fi

        echo -n "Enter your email address: "
        read -re email

        if [[ -n "${email}" ]]; then
            sed -i -e '/email = /s|# ||' -e "s/YOUR_EMAIL_ADDRESS/${email}/" "${HOME}/.gitconfig-local"
        fi

        echo -n "Enter your signing key: "
        read -re gpgsignkey

        if [[ -n "${gpgsignkey}" ]]; then
            sed -i -e '/signingkey = /s|# ||' -e "s/YOUR_GPG_SIGNING/${gpgsignkey}/" "${HOME}/.gitconfig-local"

            sed -iEe '/gpgsign = /s|false$|true|' "${HOME}/.gitconfig-local"
        fi
    else
        echo -e "${_YELLOW_FG}Update ~/.gitconfig-local with your username, email address, and gpg signing key${_RESET}"
    fi
fi

# Link the main vimrc file
ln -sf "${DOTFILES_LOCATION}/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DOTFILES_LOCATION}/git/.gitignore-global" "${HOME}/.gitignore-global"
