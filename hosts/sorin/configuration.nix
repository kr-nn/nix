{ pkgs, ... }:

{
  ## Imports =================================================================
  imports =
    [
      ../../themes/_theme.nix
      ./hardware-configuration.nix
      ../common.nix
      ../_mods/plasma.nix
      ../_mods/syncthing.nix
      ../_mods/zerotier.nix
    ];

  ## Bootloader ==============================================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ## Networking ==============================================================
  networking.hostName = "sorin";
  networking.networkmanager = {
    enable = true;
  };
  hardware.bluetooth.enable = true;

  ## Specific Drivers ========================================================
  hardware.ckb-next.enable = true;
  services.touchegg.enable = true;

  ## Sound ===================================================================
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  system.stateVersion = "23.11";
}
