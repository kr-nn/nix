#!/bin/bash

# Uninstall nix
/nix/nix-installer uninstall --no-confirm
rm -rf $HOME{.nix-channels,.nix-defexpr,.nix-profile}
rm ~/.zshrc
sudo chsh -s $(which bash)

# Restore defaults
cp /etc/skel/.* ~/
