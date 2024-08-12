{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

    # dependancies
    zip # stylua
    unzip # stylua
    gcc # telescope
    cargo # building some plugins
    neovim # neovim itself

  ];

  home.file = {
    "${config.home.homeDirectory}/.config/nvim/init.lua".source = ../../hm/dotfiles/common/nvim/init.lua;

    # This is a mutable file not in the /nix/store
    #NOTE This only works on nix 2.18 or nix 2.21.3+ mkOutOfStoreSymlink is broken outside those versions
    "${config.home.homeDirectory}/.config/nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/common/nvim/lazy-lock.json";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
