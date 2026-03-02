{ config, pkgs, libs, ... }:
{
  programs.plasma = {
    input.touchpads = [
      {
        disableWhileTyping = true;
        enable = true;
        name = "PIXA3854:00 093A:0274 Touchpad";
        naturalScroll = true;
        productId = "0274";
        vendorId = "093a";
      }
    ];
  };
}
