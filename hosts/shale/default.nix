{ config, lib, pkgs, ... }: {
  imports = [
    ../../modules/shared.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./ssh.nix
    ./wm.nix
    ./power.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  boot.kernelParams = [ "nvidia.NVreg_EnableGpuFirmware=0" ];
  boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" "nova_core" ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.allowed-users = [ "lee" ];
  nix.settings.trusted-users = [ "root" "lee" ];

  fileSystems."/mnt/estrogen" = {
    device = "/dev/disk/by-uuid/3c5f4438-ad4f-49b8-9e30-baf49f58af62";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" ];
  };

  fileSystems."/mnt/androgen" = {
    device = "/dev/disk/by-uuid/d9e3466c-3264-405e-a326-9b27990e763f";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;
  hardware.nvidia = {
    forceFullCompositionPipeline = true;
    gsp.enable = false;
    modesetting.enable = true;
    nvidiaPersistenced = true;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.steam = {
    enable = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      glibc
      zlib
      libffi
      openssl
    ];
  };

  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = [ pkgs.tridactyl-native ];
    policies.ExtensionSettings = {
      "tridactyl.vim@cmcaine.co.uk" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
      };
      "uBlock0@raymondhill.net" = {
        installation_mode = "normal_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      };
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.opentabletdriver.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [
    blender
    codex
    cudatoolkit
    discord
    distrobox
    ghostty
    imv
    krita
    nodejs
    overskride
    qgroundcontrol
    swaybg
    thunar
    zathura
    (prismlauncher.override { jdks = [ jdk8 jdk21 ]; })
  ] ++ lib.optionals (builtins.hasAttr "claude-code" pkgs) [ pkgs.claude-code ];
}
