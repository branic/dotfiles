#!/usr/bin/env bash

set -e

if [ ! -f "${HOME}/.gitconfig-local" ] ; then
  cp "${DOTFILES_LOCATION}/git/.gitconfig-local" "${HOME}/.gitconfig-local"

  echo "Enter your full name";
  read -re name
  sed -i '' "s/YOUR_NAME/${name}/" "${HOME}/.gitconfig-local"

  echo "Enter your email address";
  read -re email
  sed -i '' "s/YOUR_EMAIL_ADDRESS/${email}/" "${HOME}/.gitconfig-local"

  echo "Enter your gpg signing key";
  read -re gpgsign
  sed -i '' "s/YOUR_GPG_SIGNING/${gpgsign}/" "${HOME}/.gitconfig-local"
fi

# Link the main vimrc file
ln -sf "${DOTFILES_LOCATION}/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DOTFILES_LOCATION}/git/.gitignore-global" "${HOME}/.gitignore-global"
