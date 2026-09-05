{ pkgs, ... }:
{
  imports = [
    ../../modules/common.nix
    ../../modules/desktop.nix
    ../../modules/ssh.nix
    ../../modules/virtualization.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    bluetooth.enable = true;
    nvidia.open = true;

    # The Artist 12 (2nd Gen) has no in-kernel driver for 28bd:094a.
    opentabletdriver.enable = true;
  };

  networking = {
    hostName = "rhyolite";
    enableIPv6 = false;
    nameservers = [
      "1.1.1.1"
      "9.9.9.9"
    ];
    networkmanager.enable = true;
    firewall.allowPing = false;
  };

  time.timeZone = "America/Toronto";

  users.users.lee.extraGroups = [
    "dialout"
    "networkmanager"
  ];

  services = {
    resolved = {
      enable = true;
      settings.Resolve.DNSOverTLS = "opportunistic";
    };
    xserver.videoDrivers = [ "nvidia" ];
  };

  # Hermes uses a manually installed Node binary with a non-Nix ELF interpreter.
  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  fileSystems = {
    "/media/california" = {
      device = "/dev/disk/by-label/california";
      fsType = "btrfs";
      options = [ "nofail" ];
    };
    "/media/hawaii" = {
      device = "/dev/disk/by-label/hawaii";
      fsType = "xfs";
      options = [ "nofail" ];
    };
    "/media/nevada" = {
      device = "/dev/disk/by-label/nevada";
      fsType = "ext4";
      options = [ "nofail" ];
    };
    "/media/utah" = {
      device = "/dev/disk/by-label/utah";
      fsType = "btrfs";
      options = [
        "nofail"
        "compress=zstd:3"
      ];
    };
  };

  zramSwap.enable = true;

  # This workstation must stay awake for its server workloads.
  systemd.targets = {
    hibernate.enable = false;
    hybrid-sleep.enable = false;
    sleep.enable = false;
    suspend.enable = false;
  };
}
