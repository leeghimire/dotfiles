{
  networking = {
    enableIPv6 = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPortRanges = [ ];
    };
  };
}
