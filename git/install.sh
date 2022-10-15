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

    # Replace local config values
    echo -n "Enter your full name: "
    read -re name

    retVal=$?

    if [ $retVal -ne 0 ]; then
        echo -e "${_YELLOW_FG}Update ~/.gitconfig-local with your username${_RESET}"
    fi

    if [[ -n "${name}" ]]; then
        sed -i -E -e "/name = /s|[# ]*(name = ).*$|\1${name}|" "${HOME}/.gitconfig-local"
    else
        echo ""
    fi

    echo -n "Enter your email address: "
    read -re email

    retVal=$?

    if [ $retVal -ne 0 ]; then
        echo -e "${_YELLOW_FG}Update ~/.gitconfig-local with your email address${_RESET}"
    fi

    if [[ -n "${email}" ]]; then
        sed -i -E -e "/email = /s|[# ]*(email = ).*$|\1${email}|" "${HOME}/.gitconfig-local"
    else
        echo ""
    fi

    echo -n "Enter your signing key: "
    read -re gpgsignkey

    retVal=$?

    if [ $retVal -ne 0 ]; then
        echo -e "${_YELLOW_FG}Update ~/.gitconfig-local with your gpg signing key${_RESET}"
    fi

    if [[ -n "${gpgsignkey}" ]]; then
        sed -i -E -e "/signingkey = /s|[# ]*(signingkey = ).*$|\1${gpgsignkey}|" "${HOME}/.gitconfig-local"

        sed -i -E -e '/gpgsign = /s|false$|true|' "${HOME}/.gitconfig-local"
    else
        echo ""
    fi

fi
