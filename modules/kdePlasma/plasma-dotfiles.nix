{ inputs, ... }:
let
  comp = "plasma-dotfiles";
in
{
  flake.homeModules.${comp} = { config, pkgs, ... }: {
    programs.plasma = {
      input.touchpads = [
        { #TODO: Framework touchpad move to framework module
          disableWhileTyping = true;
          enable = true;
          name = "PIXA3854:00 093A:0274 Touchpad";
          naturalScroll = true;
          productId = "0274";
          vendorId = "093a";
        }
      ];
    };
  };
}
