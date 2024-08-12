#!/usr/bin/env bash

# Install nix: (Requires root/sudo access)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

# source nix:
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# initialize home-manager flake
rm -rf ~/.config/home-manager
git clone https://github.com/kr-nn/nix -b home ~/.config/home-manager
nix run nixpkgs#home-manager switch

# Switch to zsh once done
zsh
