{ config, pkgs, ... }: {
  imports = [
    ../../modules/shared.nix
    ../../modules/packages.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "shale";
  networking.enableIPv6 = false;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;
  services.tailscale.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 69 ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  services.openssh = {
    enable = true;
    openFirewall = false;
    ports = [ 69 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
    };
  };

  users.users.lee = {
    isNormalUser = true;
    description = "lee";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
  };
  services.displayManager.defaultSession = "hyprland";

  services.xserver.enable = true;
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
      "uBlock0@raymondhill.net" = {
        installation_mode = "normal_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      };
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    TERMINAL = "ghostty";
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    discord
    ghostty
  ];
}
