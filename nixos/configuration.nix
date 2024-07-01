{ config, lib, pkgs, ... }: {

  nixpkgs.config.allowUnfree = false;

  imports = [
    ./hardware-configuration.nix
    ./modules/audio.nix
    ./modules/bootloader.nix
    ./modules/de.nix
    ./modules/env.nix
    # ./modules/fs.nix # UNCOMMENT THIS
    ./modules/fstrim.nix
    ./modules/memory.nix
    ./modules/networking.nix
    ./modules/nix.nix
    # ./modules/nvidia.nix #unfree
    # ./modules/steam.nix #unfree
    ./modules/system76.nix
    ./modules/users.nix
    ./modules/virtmanager.nix
    ./packages.nix
  ];

  networking.hostName = "nixos";

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "24.05";
}

