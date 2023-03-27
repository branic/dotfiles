#!/usr/bin/env bash
{ # This ensures the entire script is downloaded

  set -eo pipefail

  DOTFILES_LOCATION="${DOTFILES_LOCATION:-${HOME}/.dotfiles}"
  # bindir="${HOME}/.local/bin"
  REPOURL="https://github.com/branic/dotfiles.git"

  export DOTFILES_LOCATION

  echo "Dotfiles location set to ${DOTFILES_LOCATION}"

  # Ensure Git is installed
  if ! which git >/dev/null; then
    echo "Error: git is not installed"
    exit 1
  fi

  if [ -d "${DOTFILES_LOCATION}/.git" ]; then
    echo "Updating dotfiles using existing git..."
    cd "${DOTFILES_LOCATION}"
    git pull --quiet --rebase origin main || exit 1
  else
    echo "Checking out dotfiles using git..."
    rm -rf "${DOTFILES_LOCATION}"
    git clone --quiet --depth=1 "${REPOURL}" "${DOTFILES_LOCATION}"
  fi

  cd "${DOTFILES_LOCATION}"

  # Install configurations
  # Example: ./bin/dotfiles install <config type>

  # Configs common to Linux and MacOS
  echo "Installing common (Linux/MacOS) configs..."
  ./bin/dotfiles install vim
  ./bin/dotfiles install git
  ./bin/dotfiles install bash
  ./bin/dotfiles install omz

  # Configs specific to Linux
  if [ "$(uname -s)" == "Linux" ]; then
    echo "Installing Linux specific configs..."
    ./bin/dotfiles install tmux
    ./bin/dotfiles install powerline
    ./bin/dotfiles install terminator
  fi

  # Configs specific to MacOS
  if [ "$(uname -s)" == "Darwin" ]; then
    echo "Installing MacOS specific configs..."
    ./bin/dotfiles install brew
  fi

} # This ensures the entire script is downloaded
