{ pkgs, ... }: {
  imports = [
    ../../modules/shared.nix
    ../../modules/nvidia.nix
    ../../modules/niri-desktop.nix
    ../../modules/gaming.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./ssh.nix
    ./memory.nix
    ./sleep.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  time.timeZone = "America/Toronto";

  nixpkgs.config.allowUnfree = true;
  nix.settings.allowed-users = [ "lee" ];
  nix.settings.trusted-users = [ "root" "lee" ];

  fileSystems."/media/california" = {
    device = "/dev/disk/by-uuid/4679bfa9-0530-4b06-adbe-805d92ca01e7";
    fsType = "btrfs";
    options = [ "nofail" "x-systemd.automount" ];
  };

  fileSystems."/media/nevada" = {
    device = "/dev/disk/by-uuid/d9e3466c-3264-405e-a326-9b27990e763f";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" ];
  };

  fileSystems."/media/utah" = {
    device = "/dev/disk/by-uuid/3c5f4438-ad4f-49b8-9e30-baf49f58af62";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" ];
  };

  fileSystems."/media/hawaii" = {
    device = "/dev/disk/by-uuid/88110494-012a-4799-83e7-0ca7cbdbdc7f";
    fsType = "btrfs";
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
