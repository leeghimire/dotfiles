{ inputs, ... }:
{
  home-manager.users.lee = {
    imports = [ inputs.rex.homeManagerModules.default ];

    # ~/.ssh/config is hand-managed, so `rex terminfo setup` adds the guard instead.
    programs.rex.sshGuard = false;

    services.rex = {
      enable = true;
      tailscale.enable = false;
    };
  };
}
