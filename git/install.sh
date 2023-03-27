#!/usr/bin/env bash

set -e

# See https://en.wikipedia.org/wiki/ANSI_escape_code
_YELLOW_FG="\e[38;5;226m"
_RESET="\e[0m"

# Setup the local only config file
if [ ! -f "${HOME}/.gitconfig-local" ]; then
    cp "${DOTFILES_LOCATION}/git/.gitconfig-local" "${HOME}/.gitconfig-local"

    # Determine default author name
    if [ "$(uname -s)" == "Darwin" ]; then
        git_authorname=$(dscl . -read /Users/"$(whoami)" RealName | tail -n1)
    elif [ "$(uname -s)" == "Linux" ]; then
        git_authorname=$(getent passwd "$(whoami)" | cut -d ':' -f 5 | cut -d ',' -f 1)
    fi

    # Remove leading and trailing whitespace
    shopt -s extglob
    git_authorname="${git_authorname##*( )}"
    git_authorname="${git_authorname%%*( )}"
    shopt -u extglob

    # Replace local config values
    echo -n "Enter your full name (Default: ${git_authorname}) : "
    read -re name

    retVal=$?

    if [ $retVal -ne 0 ]; then
        echo -e "${_YELLOW_FG}Update ~/.gitconfig-local with your username${_RESET}"
    fi

    if [[ -n "${name}" ]]; then
        # Remove leading and trailing whitespace
        shopt -s extglob
        name="${name##*( )}"
        name="${name%%*( )}"
        shopt -u extglob

        sed -i.bak -E "/name = /s|[# ]*(name = ).*$|\1${name}|" "${HOME}/.gitconfig-local"
    else
        if [[ -n "${git_authorname}" ]]; then
            sed -i.bak -E "/name = /s|[# ]*(name = ).*$|\1${git_authorname}|" "${HOME}/.gitconfig-local"
        fi
        echo
    fi

    echo -n "Enter your email address: "
    read -re email

    retVal=$?

    if [ $retVal -ne 0 ]; then
        echo -e "${_YELLOW_FG}Update ~/.gitconfig-local with your email address${_RESET}"
    fi

    if [[ -n "${email}" ]]; then
        sed -i.bak -E "/email = /s|[# ]*(email = ).*$|\1${email}|" "${HOME}/.gitconfig-local"
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
        sed -i.bak -E "/signingkey = /s|[# ]*(signingkey = ).*$|\1${gpgsignkey}|" "${HOME}/.gitconfig-local"

        sed -i.bak -E '/gpgsign = /s|false$|true|' "${HOME}/.gitconfig-local"
    else
        echo ""
    fi

    rm -f "${HOME}/.gitconfig-local.bak"
fi

# Link the git config files
ln -sf "${DOTFILES_LOCATION}/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DOTFILES_LOCATION}/git/.gitignore-global" "${HOME}/.gitignore-global"
