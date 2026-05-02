{ pkgs, ... }: {
  imports = [
    ../../modules/shared.nix
    ../../modules/nvidia.nix
    ../../modules/niri-desktop.nix
    ../../modules/gaming.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./ssh.nix
    ./power.nix
  ];

  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  time.timeZone = "America/Toronto";

  nixpkgs.config.allowUnfree = true;
  nix.settings.allowed-users = [ "lee" ];
  nix.settings.trusted-users = [ "root" "lee" ];

  fileSystems."/media/estrogen" = {
    device = "/dev/disk/by-uuid/3c5f4438-ad4f-49b8-9e30-baf49f58af62";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" ];
  };

  fileSystems."/media/androgen" = {
    device = "/dev/disk/by-uuid/d9e3466c-3264-405e-a326-9b27990e763f";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" ];
  };

  hardware.opentabletdriver.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
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

  environment.systemPackages = with pkgs; [
    cudatoolkit
    distrobox
  ];
}
