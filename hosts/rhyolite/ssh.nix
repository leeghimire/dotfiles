{ ... }: {
  services.openssh = {
    enable = true;
    openFirewall = false;
    ports = [ 69 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "lee" ];
      AllowAgentForwarding = false;
      AllowTcpForwarding = false;
      MaxAuthTries = 3;
      LoginGraceTime = 20;
    };
  };
}
