{ pkgs, ... }: {
  imports = [
    ../../modules/shared.nix
    ../../modules/nvidia.nix
    ../../modules/plasma-desktop.nix
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

  # en_DK = English with ISO 8601 dates, 24-hour clock, metric, A4 paper.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "en_DK.UTF-8";
    LC_MEASUREMENT = "en_DK.UTF-8";
    LC_PAPER = "en_DK.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.allowed-users = [ "lee" ];
  nix.settings.trusted-users = [ "root" "lee" ];

  virtualisation.docker.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = true;
  };

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
    options = [ "nofail" ];
  };

  fileSystems."/media/nevada" = {
    device = "/dev/disk/by-uuid/d9e3466c-3264-405e-a326-9b27990e763f";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/media/utah" = {
    device = "/dev/disk/by-uuid/ade1198f-9c72-4907-840f-42cc6725a55c";
    fsType = "btrfs";
    options = [ "nofail" "compress=zstd:3" ];
  };

  fileSystems."/media/hawaii" = {
    device = "/dev/disk/by-uuid/88110494-012a-4799-83e7-0ca7cbdbdc7f";
    fsType = "btrfs";
    options = [ "nofail" "compress=zstd:3" ];
  };

  # The Artist 12 (2nd Gen) has no in-kernel driver (hid-uclogic doesn't know
  # 28bd:094a), so KDE's native tablet support can't see it — OTD is required.
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
