#!/usr/bin/env bash

set -e

if test ! "$(command -v brew)"; then
  printf "\n🚀 Installing the brew package manager\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Packages to install with brew
MY_BREW_PKGS=(
    gnupg
    podman
    podman-desktop
)

# Install the packages
for pkg in "${MY_BREW_PKGS[@]}"; do
    printf "Installing %s\n" "${pkg}"
    brew install "${pkg}"
done

# Cleanup
brew autoremove -v
brew cleanup --prune=all
