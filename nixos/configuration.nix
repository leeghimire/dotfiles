{ inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  disabledModules = [
    ./modules/sound.nix
    ./modules/zram.nix
    ./modules/env.nix
    ./modules/xserver.nix
    ./modules/virtmanager.nix
    ./modules/trim.nix
  ];

  users = {
    #defaultUserShell = pkgs.zsh;

    users.lee = {
      isNormalUser = true;
      description = "Lee NLN";
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
      packages = with pkgs; [];
    };
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "lee";

  networking.networkmanager.enable = true;

  nixpkgs.overlays = [ inputs.polymc.overlay ];

  networking.hostName = "nixos"; # Define your hostname.

  time.timeZone = "America/Toronto"; # Set your time zone.

  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/<UUID>"; #change
      preLVM = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [];
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ]; 

  system.stateVersion = "23.05"; # Don't change it bro
}
