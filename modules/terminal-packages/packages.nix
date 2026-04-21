{ inputs, mypkgs, ... }:
let
  comp = "terminal-packages";
in
{
  flake.homeModules.${comp} = { pkgs, ... }: {
    home.packages = with pkgs; [
      # Shell tools
      tmux
      bat
      fzf
      manix
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
      superfile
      inputs.neix.packages.x86_64-linux.default
      comma

      # Terminal Apps
      rbw
      glow

      # Nix things
      nix-prefetch-git
      nixd

      # custom scripts
      (pkgs.writeShellScriptBin "flink" (builtins.readFile ./flink) )
      (pkgs.writeShellScriptBin "hmpr"  (builtins.readFile ./hmpr) )
      (pkgs.writeShellScriptBin "git-chop"  (builtins.readFile ./git-chop) )
      (pkgs.writeShellScriptBin "gitauth" (builtins.readFile ./gitauth) )

      (pkgs.writeShellScriptBin "nosw"    ''nixos-rebuild switch --upgrade'')
      (pkgs.writeShellScriptBin "nobo"    ''nixos-rebuild boot --upgrade'')
      (pkgs.writeShellScriptBin "note"    ''nixos-rebuild test'')
      (pkgs.writeShellScriptBin "nobu"    ''nixos-rebuild build'')

      (pkgs.writeShellScriptBin "nr"      ''nix run github:nixos/nixpkgs/master#"$1" -- ''${@:2}'')
      (pkgs.writeShellScriptBin "nixdoc"  ''manix "" | sed -n 's/^# \(.*\) \?.*/\1/p' | fzf --preview="manix '''{}'''" | xargs manix'')
    ];
  };
}
