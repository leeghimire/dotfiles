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

  nixpkgs.config.allowUnfree = true;

  fileSystems."/mnt/estrogen" = {
    device = "/dev/disk/by-uuid/6EA4340CA433D575";
    fsType = "ntfs3";
    options = [ "nofail" "x-systemd.automount" "uid=1000" "gid=100" "umask=022" ];
  };

  fileSystems."/mnt/androgen" = {
    device = "/dev/disk/by-uuid/9692DF2692DF0A1F";
    fsType = "ntfs3";
    options = [ "nofail" "x-systemd.automount" "uid=1000" "gid=100" "umask=022" ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

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

  environment.systemPackages = with pkgs; [
    codex
    cudatoolkit
    discord
    ghostty
    nodejs
  ] ++ lib.optionals (builtins.hasAttr "claude-code" pkgs) [ pkgs.claude-code ];
}
