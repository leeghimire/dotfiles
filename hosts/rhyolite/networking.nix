{ config, ... }: {
  networking.hostName = "rhyolite";
  networking.enableIPv6 = false;

  networking.nameservers = ["1.1.1.1" "9.9.9.9"];

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  services.resolved = {
    enable = true;
    settings.Resolve = {
      FallbackDNS = ["9.9.9.9" "1.1.1.1"];
      DNSOverTLS = "opportunistic";
    };
  };

  services.tailscale = {
    enable = true;
    extraSetFlags = [ "--operator=lee" ];
  };

  # Funnel handlers are runtime state, so reapply this one whenever tailscaled starts.
  systemd.services.tailscaled.wants = [ "tailscale-funnel-ssh.service" ];

  # Public TLS envelope for the local OpenSSH daemon. This lets clients
  # connect without joining the tailnet while keeping sshd on port 69.
  systemd.services.tailscale-funnel-ssh = {
    description = "Tailscale Funnel for OpenSSH";
    after = [ "tailscaled.service" "tailscaled-set.service" "sshd.service" ];
    bindsTo = [ "tailscaled.service" ];
    wants = [ "sshd.service" ];
    wantedBy = [ "multi-user.target" ];
    unitConfig.StartLimitIntervalSec = 0;

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = "2s";
      # tailscaled.service being active does not mean its backend is Running yet.
      ExecStartPre = "${config.services.tailscale.package}/bin/tailscale wait --timeout=60s";
      ExecStart = "${config.services.tailscale.package}/bin/tailscale funnel --bg --yes --tls-terminated-tcp=443 tcp://127.0.0.1:69";
      ExecStop = "${config.services.tailscale.package}/bin/tailscale funnel --tls-terminated-tcp=443 off";
    };
  };

  networking.firewall = {
    allowedUDPPorts = [ config.services.tailscale.port ];
    interfaces.tailscale0.allowedTCPPorts = [ 69 ];
  };
}
