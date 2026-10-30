{ inputs, ... }:
{
  home-manager.users.lee = {
    imports = [ inputs.rex.homeManagerModules.default ];

    # ~/.ssh/config is hand-managed, so `rex terminfo setup` adds the guard instead.
    programs.rex.sshGuard = false;

    services.rex = {
      enable = true;
      # Uses the host's tailscaled, not the copy built into Rex.
      extraListen = [ "tailnet://:7297" ];
    };
  };

  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 7297 ];
}
