{ pkgs, ... }: {
  imports = [
    ../../modules/plasma.nix
    ../../modules/ssh.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";

  home-manager.users.lee.imports = [ ../../users/lee/rhyolite.nix ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  zramSwap.enable = true;

  networking = {
    hostName = "rhyolite";
    enableIPv6 = false;
    nameservers = [ "1.1.1.1" "9.9.9.9" ];
    networkmanager.enable = true;
  };

  services.resolved = {
    enable = true;
    settings.Resolve.DNSOverTLS = "opportunistic";
  };

  users.users.git = {
    isSystemUser = true;
    group = "git";
    home = "/media/hawaii/origin";
    shell = "${pkgs.git}/bin/git-shell";
    openssh.authorizedKeys.keys =
      (import ../../users/lee/authorized-keys.nix);
  };

  users.groups.git = { };
  users.users.lee.extraGroups = [ "git" ];
  services.openssh.settings.AllowUsers = [ "git" ];

  # Keep the RTX 2060 GPU function (0000:04:00.0) on vfio-pci at boot so
  # games only enumerate the RTX 3060. Live compute switching is not yet set up.
  boot.initrd.kernelModules = [ "vfio_pci" ];
  boot.kernelParams = [ "vfio-pci.ids=10de:1f08" ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  time.timeZone = "America/Toronto";

  # en_DK = English with ISO 8601 dates, 24-hour clock, metric, A4 paper.
  i18n.extraLocaleSettings = {
    LC_TIME = "en_DK.UTF-8";
    LC_MEASUREMENT = "en_DK.UTF-8";
    LC_PAPER = "en_DK.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    allowed-users = [ "lee" ];
  };

  virtualisation.podman.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
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
    device = "/dev/disk/by-uuid/b570586c-e3ea-41c7-8660-df1aa4375aad";
    fsType = "xfs";
    options = [ "nofail" ];
  };

  # The Artist 12 (2nd Gen) has no in-kernel driver (hid-uclogic doesn't know
  # 28bd:094a), so KDE's native tablet support can't see it — OTD is required.
  hardware.opentabletdriver.enable = true;

  programs.nix-ld.enable = true;

  hardware.bluetooth.enable = true;
}
