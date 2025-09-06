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
    unrar
    curl
    nmap
    fastfetch
    usbutils
    pciutils
    htop
    jq
    gum

    # Terminal Apps
    bitwarden-cli
    glow

    # Nix things
    nix-prefetch-git
    nixd
    nh

    # custom scripts
    (pkgs.writeShellScriptBin "flink" (builtins.readFile ../scripts/flink) )
    (pkgs.writeShellScriptBin "hmpr"  (builtins.readFile ../scripts/hmpr) )
    (pkgs.writeShellScriptBin "git-chop"  (builtins.readFile ../scripts/git-chop) )
    (pkgs.writeShellScriptBin "gitauth" (builtins.readFile ../scripts/gitauth) )

    (pkgs.writeShellScriptBin "nosw"  ''nixos-rebuild switch'')
    (pkgs.writeShellScriptBin "note"  ''nixos-rebuild test'')
    (pkgs.writeShellScriptBin "nobo"  ''nixos-rebuild boot'')
    (pkgs.writeShellScriptBin "nobu"  ''nixos-rebuild build'')

    (pkgs.writeShellScriptBin "nr"    ''nix run github:nixos/nixpkgs/master#"$1" -- ''${@:2}'')
  ];
}
