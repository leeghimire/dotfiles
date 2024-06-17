{ inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix

    ./modules/bootloader.nix
    ./modules/sound.nix
    ./modules/zram.nix
    ./modules/env.nix
    ./modules/user.nix
    ./modules/xserver.nix
    ./modules/nm.nix
    ./modules/virtmanager.nix
    ./modules/trim.nix
  ];

  disabledModules = [
  ];

  nixpkgs.overlays = [ inputs.polymc.overlay ];

  networking.hostName = "nixos"; # Define your hostname.

  time.timeZone = "America/Toronto"; # Set your time zone.

  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.

  system.stateVersion = "23.05"; # Don't change it bro
}
