#!/bin/bash

# Uninstall nix
/nix/nix-installer uninstall --no-confirm
rm -rf $HOME{.nix-channels,.nix-defexpr,.nix-profile}
