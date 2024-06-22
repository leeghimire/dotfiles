{ pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/bundle.nix
    ./packages.nix
  ];

  disabledModules = [
    ./modules/devsuite.nix
    ./modules/nvidia.nix
    ./modules/sound.nix
    ./modules/suckless.nix #requires xserver.nix
    ./modules/virtmanager.nix
    ./modules/xserver.nix
  ];

  nixpkgs.config.allowUnfree = false;

  services.fstrim.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 100;
    priority = 999;
  };

  users = {
    #defaultUserShell = pkgs.zsh;

    users.lee = {
      isNormalUser = true;
      description = "Lee NLN";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      packages = with pkgs; [];
    };
  };

  environment.variables = {
    EDITOR = "nvim";
    RANGER_LOAD_DEFAULT_RC = "FALSE";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GSETTINGS_BACKEND = "keyfile";
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "lee";

  networking.networkmanager.enable = true;

  nixpkgs.overlays = [];

  networking.hostName = "nixos"; # Define your hostname.

  time.timeZone = "America/Toronto"; # Set your time zone.

  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/<UUID>";
      preLVM = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [];

  boot.kernelParams = [ "processor.max_cstate=4" "amd_iomu=soft" "idle=nomwait"];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  boot.extraModulePackages = [];

  system.stateVersion = "23.05";
}
