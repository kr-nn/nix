{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Shell tools
    tmux
    bat
    fzf
    fd
    parallel
    ctpv
    eza
    ripgrep
    age
    unrar
    git
    curl
    nmap
    fastfetch
    usbutils
    pciutils
    htop
    jq
    minio-client

    # Terminal Apps
    bitwarden-cli
    glow

    # Neovim
    zip
    unzip
    gcc
    cargo

    # Nix things
    nix-prefetch-git
    nixd
    nh

    # custom scripts
    (pkgs.writeShellScriptBin "flink" (builtins.readFile ./scripts/flink) )
    (pkgs.writeShellScriptBin "hmpr"  (builtins.readFile ./scripts/hmpr) )
    (pkgs.writeShellScriptBin "git-chop"  (builtins.readFile ./scripts/git-chop) )
    (pkgs.writeShellScriptBin "gitauth" (builtins.readFile ./scripts/gitauth) )

    (pkgs.writeShellScriptBin "no"    ''nixos-rebuild'')
    (pkgs.writeShellScriptBin "nosw"  ''nixos-rebuild switch'')
    (pkgs.writeShellScriptBin "note"  ''nixos-rebuild test'')
    (pkgs.writeShellScriptBin "nobo"  ''nixos-rebuild boot'')
    (pkgs.writeShellScriptBin "nobu"  ''nixos-rebuild build'')

    (pkgs.writeShellScriptBin "ns"    ''nix search github:nixos/nixpkgs/master '')
    (pkgs.writeShellScriptBin "nr"    ''nix run github:nixos/nixpkgs/master#"$1" -- ''${@:2}'')
    (pkgs.writeShellScriptBin "nsh"    ''nix shell github:nixos/nixpkgs/master#"$1" -- ''${@:2}'')
    (pkgs.writeShellScriptBin "nri"   ''nix run github:nixos/nixpkgs/master#"$1" --impure -- ''${@:2}'')
    (pkgs.writeShellScriptBin "nshi"   ''nix shell github:nixos/nixpkgs/master#"$1" --impure -- ''${@:2}'')
  ];
}
