{ config, ... }: {
  networking.hostName = "shale";
  networking.enableIPv6 = false;

  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 69 ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
