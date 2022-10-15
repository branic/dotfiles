#!/usr/bin/env bash

set -e

# See https://en.wikipedia.org/wiki/ANSI_escape_code
_YELLOW_FG="\e[38;5;226m"
_RESET="\e[0m"

# Link the main vimrc file
ln -sf "${DOTFILES_LOCATION}/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DOTFILES_LOCATION}/git/.gitignore-global" "${HOME}/.gitignore-global"

# Copy local only file
if [ ! -f "${HOME}/.gitconfig-local" ]; then
    cp "${DOTFILES_LOCATION}/git/.gitconfig-local" "${HOME}/.gitconfig-local"
fi

# Replace local config values
if [[ $- == *i* ]]; then
    echo -n "Enter your full name: "
    read -re name

    if [[ -n "${name}" ]]; then
        sed -iE -e "/name = /s|[# ]*(name = ).*|\1${name}|" "${HOME}/.gitconfig-local"
    fi

    echo -n "Enter your email address: "
    read -re email

    if [[ -n "${email}" ]]; then
        sed -iE -e "/email = /s|[# ]*(email = ).*|\1${email}|" "${HOME}/.gitconfig-local"
    fi

    echo -n "Enter your signing key: "
    read -re gpgsignkey

    if [[ -n "${gpgsignkey}" ]]; then
        sed -iE -e "/signingkey = /s|[# ]*(signingkey = ).*|\1${gpgsignkey}|" "${HOME}/.gitconfig-local"

        sed -iE -e '/gpgsign = /s|false$|true|' "${HOME}/.gitconfig-local"
    fi
else
    echo -e "${_YELLOW_FG}Update ~/.gitconfig-local with your username, email address, and gpg signing key${_RESET}"
fi
