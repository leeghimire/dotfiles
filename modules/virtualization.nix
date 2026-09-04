{ pkgs, ... }:
{
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.lee.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    distrobox
    podman-desktop
  ];
}
