{ pkgs, ... }:
{

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking
  networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 60999; } ]; # ephemeral port range
  networking.firewall.allowedTCPPortRanges = [ { from = 32768; to = 60999; } ]; # ephemeral port range

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  users.users.kyle = {
    isNormalUser = true;
    description = "kyle";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # zsh needs this:
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };
}
