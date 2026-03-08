{ config, ... }: {
  networking.hostName = "shale";
  networking.enableIPv6 = false;

  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ config.services.tailscale.port ];
    interfaces.tailscale0.allowedTCPPorts = [ 69 ];
  };
}
