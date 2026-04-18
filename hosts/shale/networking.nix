{ config, ... }: {
  networking.hostName = "shale";
  networking.enableIPv6 = false;

  networking.nameservers = ["1.1.1.1" "9.9.9.9"];

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  services.resolved = {
    enable = true;
    fallbackDns = ["9.9.9.9" "1.1.1.1"];
    dnsovertls = "opportunistic";
  };

  services.tailscale.enable = true;

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ config.services.tailscale.port ];
    interfaces.tailscale0.allowedTCPPorts = [ 69 ];
  };
}
