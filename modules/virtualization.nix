{ pkgs, ... }: {
  virtualisation.docker.enable = true;

  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  users.users.lee = {
    extraGroups = [ "docker" ];
    packages = with pkgs; [
      distrobox
      podman-desktop
    ];
  };
}
