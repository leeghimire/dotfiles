{ pkgs, ... }: {
  imports = [
    ../../modules/shared.nix
    ../../modules/nvidia.nix
    ../../modules/niri-desktop.nix
    ../../modules/gaming.nix
    ./display.nix
    ./openrgb.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./ssh.nix
    ./memory.nix
    ./sleep.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/Toronto";

  nixpkgs.config.allowUnfree = true;
  nix.settings.allowed-users = [ "lee" ];
  nix.settings.trusted-users = [ "root" "lee" ];

  # Weekly, scheduled (not random) update to the latest unstable + rebuild.
  # Never reboots on its own (allowReboot defaults to false).
  system.autoUpgrade = {
    enable = true;
    flake = "/home/lee/Repos/dotfiles";
    flags = [ "--recreate-lock-file" ];
    dates = "Sun 04:00";
  };

  # Auto-cull old generations and unreferenced store paths weekly.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  fileSystems."/media/california" = {
    device = "/dev/disk/by-uuid/4679bfa9-0530-4b06-adbe-805d92ca01e7";
    fsType = "btrfs";
    options = [ "nofail" "x-gvfs-show" ];
  };

  fileSystems."/media/nevada" = {
    device = "/dev/disk/by-uuid/d9e3466c-3264-405e-a326-9b27990e763f";
    fsType = "ext4";
    options = [ "nofail" "x-gvfs-show" ];
  };

  fileSystems."/media/utah" = {
    device = "/dev/disk/by-uuid/ade1198f-9c72-4907-840f-42cc6725a55c";
    fsType = "btrfs";
    options = [ "nofail" "x-gvfs-show" "compress=zstd:3" ];
  };

  fileSystems."/media/hawaii" = {
    device = "/dev/disk/by-uuid/88110494-012a-4799-83e7-0ca7cbdbdc7f";
    fsType = "btrfs";
    options = [ "nofail" "x-gvfs-show" "compress=zstd:3" ];
  };

  hardware.opentabletdriver.enable = true;

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
}
