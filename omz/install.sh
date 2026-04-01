#! /usr/bin/env bash

set -eo pipefail

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

if ! command_exists zsh; then
  echo "Warning: zsh is not installed. Install zsh first, then re-run this installer." >&2
  exit 0
fi

if [ -z "${DOTFILES_LOCATION:-}" ]; then
  echo "Error: DOTFILES_LOCATION is not set." >&2
  exit 1
fi

ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

if [ -d "${HOME}/.oh-my-zsh" ]; then
  echo "oh-my-zsh is already installed"
else
  tmp=$(mktemp)
  cleanup() { rm -f "$tmp"; }
  trap cleanup EXIT
  curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o "$tmp"
  if ! sh "$tmp" "" --unattended; then
    echo "Error: oh-my-zsh install failed. Fix the issue above and re-run." >&2
    exit 1
  fi
  rm -f "$tmp"
  trap - EXIT
fi

if [ ! -d "$ZSH_CUSTOM" ]; then
  echo "Error: ${ZSH_CUSTOM} is missing; oh-my-zsh did not install correctly." >&2
  exit 1
fi

ln -sf "${DOTFILES_LOCATION}/omz/aliases.zsh" "${ZSH_CUSTOM}/aliases.zsh"
ln -sf "${DOTFILES_LOCATION}/omz/exports.zsh" "${ZSH_CUSTOM}/exports.zsh"
ln -sf "${DOTFILES_LOCATION}/omz/functions.zsh" "${ZSH_CUSTOM}/functions.zsh"
